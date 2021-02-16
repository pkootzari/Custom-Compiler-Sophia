package main.visitor.codeGenerator;

import com.sun.jdi.event.StepEvent;
import main.ast.nodes.Program;
import main.ast.nodes.declaration.classDec.ClassDeclaration;
import main.ast.nodes.declaration.classDec.classMembersDec.ConstructorDeclaration;
import main.ast.nodes.declaration.classDec.classMembersDec.FieldDeclaration;
import main.ast.nodes.declaration.classDec.classMembersDec.MethodDeclaration;
import main.ast.nodes.declaration.variableDec.VarDeclaration;
import main.ast.nodes.expression.*;
import main.ast.nodes.expression.operators.BinaryOperator;
import main.ast.nodes.expression.operators.UnaryOperator;
import main.ast.nodes.expression.values.ListValue;
import main.ast.nodes.expression.values.NullValue;
import main.ast.nodes.expression.values.primitive.BoolValue;
import main.ast.nodes.expression.values.primitive.IntValue;
import main.ast.nodes.expression.values.primitive.StringValue;
import main.ast.nodes.statement.*;
import main.ast.nodes.statement.loop.BreakStmt;
import main.ast.nodes.statement.loop.ContinueStmt;
import main.ast.nodes.statement.loop.ForStmt;
import main.ast.nodes.statement.loop.ForeachStmt;
import main.ast.types.NullType;
import main.ast.types.Type;
import main.ast.types.functionPointer.FptrType;
import main.ast.types.list.ListNameType;
import main.ast.types.list.ListType;
import main.ast.types.single.BoolType;
import main.ast.types.single.ClassType;
import main.ast.types.single.IntType;
import main.ast.types.single.StringType;
import main.symbolTable.SymbolTable;
import main.symbolTable.exceptions.ItemNotFoundException;
import main.symbolTable.items.ClassSymbolTableItem;
import main.symbolTable.items.FieldSymbolTableItem;
import main.symbolTable.items.MethodSymbolTableItem;
import main.symbolTable.items.SymbolTableItem;
import main.symbolTable.utils.graph.Graph;
import main.visitor.Visitor;
import main.visitor.typeChecker.ExpressionTypeChecker;
import org.antlr.v4.misc.EscapeSequenceParsing;
import parsers.SophiaParser;

import java.awt.*;
import java.awt.desktop.SystemEventListener;
import java.awt.image.AreaAveragingScaleFilter;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class CodeGenerator extends Visitor<String> {
    ExpressionTypeChecker expressionTypeChecker;
    Graph<String> classHierarchy;
    private String outputPath;
    private FileWriter currentFile;
    private ClassDeclaration currentClass;
    private MethodDeclaration currentMethod;
    private int lastTempValue;
    private String stack_size;
    private String locals_size;
    private int labelNum = 0;
    private ArrayList<String> breaks;
    private ArrayList<String> continues;
    private ArrayList<Integer> temp_vars;

    public CodeGenerator(Graph<String> classHierarchy) {
        this.classHierarchy = classHierarchy;
        this.expressionTypeChecker = new ExpressionTypeChecker(classHierarchy);
        this.prepareOutputFolder();
        this.lastTempValue = 0;
        this.stack_size = "128";
        this.locals_size = "128";
        this.breaks = new ArrayList<>();
        this.continues = new ArrayList<>();
        this.temp_vars = new ArrayList<>();
    }

    private void prepareOutputFolder() {
        this.outputPath = "output/";
        String jasminPath = "utilities/jarFiles/jasmin.jar";
        String listClassPath = "utilities/codeGenerationUtilityClasses/List.j";
        String fptrClassPath = "utilities/codeGenerationUtilityClasses/Fptr.j";
        try{
            File directory = new File(this.outputPath);
            File[] files = directory.listFiles();
            if(files != null)
                for (File file : files)
                    file.delete();
            directory.mkdir();
        }
        catch(SecurityException e) { }
        copyFile(jasminPath, this.outputPath + "jasmin.jar");
        copyFile(listClassPath, this.outputPath + "List.j");
        copyFile(fptrClassPath, this.outputPath + "Fptr.j");
    }

    private void copyFile(String toBeCopied, String toBePasted) {
        try {
            File readingFile = new File(toBeCopied);
            File writingFile = new File(toBePasted);
            InputStream readingFileStream = new FileInputStream(readingFile);
            OutputStream writingFileStream = new FileOutputStream(writingFile);
            byte[] buffer = new byte[1024];
            int readLength;
            while ((readLength = readingFileStream.read(buffer)) > 0)
                writingFileStream.write(buffer, 0, readLength);
            readingFileStream.close();
            writingFileStream.close();
        } catch (IOException e) { }
    }

    private void createFile(String name) {
        try {
            String path = this.outputPath + name + ".j";
            File file = new File(path);
            file.createNewFile();
            FileWriter fileWriter = new FileWriter(path);
            this.currentFile = fileWriter;
        } catch (IOException e) {}
    }

    private void addCommand(String command) {
        try {
            command = String.join("\n\t\t", command.split("\n"));
            if(command.startsWith("Label_"))
                this.currentFile.write("\t" + command + "\n");
            else if(command.startsWith(".") || command.startsWith(";"))
                this.currentFile.write(command + "\n");
            else
                this.currentFile.write("\t\t" + command + "\n");
            this.currentFile.flush();
        } catch (IOException e) {}
    }

    private String makeTypeSignature(Type t, boolean premitive) {
        if(t instanceof IntType) {
            if(premitive)
                return "I";
            else
                return "Ljava/lang/Integer;";
        } if(t instanceof BoolType) {
            if(premitive)
                return "Z";
            else
                return "Ljava/lang/Boolean;";
        } if(t instanceof StringType)
            return "Ljava/lang/String;";
        if(t instanceof ClassType)
            return "L"+((ClassType) t).getClassName().getName()+";";
        if(t instanceof ListType)
            return "LList;";
        if(t instanceof FptrType)
            return "LFptr;";
        if(t instanceof NullType)
            return "V";
        return null;
    }

    private void initialize(Type t) {
        if(t instanceof IntType) {
            addCommand("ldc 0");
            addCommand("invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;");
        } else if(t instanceof BoolType) {
            addCommand("ldc 0");
            addCommand("invokestatic java/lang/Boolean/valueOf(Z)Ljava/lang/Boolean;");
        } else if(t instanceof StringType) {
            addCommand("ldc \"\"");
        } else if(t instanceof ClassType || t instanceof FptrType) {
            addCommand("aconst_null");
        } else if(t instanceof ListType) {
            addCommand("new List");
            addCommand("dup");
            addCommand("new java/util/ArrayList");
            addCommand("dup");
            addCommand("invokespecial java/util/ArrayList/<init>()V");
            for(ListNameType e : ((ListType) t).getElementsTypes()) {
                addCommand("dup");
                initialize(e.getType());
//                addCommand("checkcast java/lang/Object");     // not really sure this should be here
                addCommand("invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z");
                addCommand("pop");
            }
            addCommand("invokespecial List/<init>(Ljava/util/ArrayList;)V");
        }
    }

    private String toPremitive(Type t) {
        if(t instanceof IntType)
            return "invokevirtual java/lang/Integer/intValue()I\n";
        if(t instanceof BoolType)
            return "invokevirtual java/lang/Boolean/booleanValue()Z\n";
        return null;
    }

    private String toNonpremitive(Type t) {
        if(t instanceof IntType)
            return "invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;\n";
        if(t instanceof BoolType)
            return "invokestatic java/lang/Boolean/valueOf(Z)Ljava/lang/Boolean;\n";
        return null;
    }

    private int getLable() {
        return ++this.labelNum;
    }

    private void addDefaultConstructor() {      // done I think
        addCommand(";this is a default constructor");
        addCommand(".method public <init>()V");
        addCommand(".limit locals "+this.stack_size);
        addCommand(".limit stack "+this.locals_size);
        addCommand("aload 0");
        if(currentClass.getParentClassName() == null)
            addCommand("invokenonvirtual java/lang/Object/<init>()V");
        else {
            String parentName = currentClass.getParentClassName().getName();
            addCommand("invokespecial "+parentName+"/<init>()V");
        }
        for(FieldDeclaration f : currentClass.getFields()) {
            addCommand("aload_0");
            initialize(f.getVarDeclaration().getType());
            String className = currentClass.getClassName().getName();
            String fieldName = f.getVarDeclaration().getVarName().getName();
            String signiture = makeTypeSignature(f.getVarDeclaration().getType(), false);
            addCommand("putfield "+className+"/"+fieldName+" "+signiture);
        }
        addCommand("return");
        addCommand(".end method");
        addCommand("");
    }

    private void addStaticMainMethod() {        // done I think
        addCommand(";this is the added static main method");
        addCommand(".method public static main([Ljava/lang/String;)V");
        addCommand(".limit stack "+this.stack_size);
        addCommand(".limit locals "+this.stack_size);
        addCommand("new Main");
        addCommand("invokespecial Main/<init>()V");
        addCommand("return");
        addCommand(".end method");
        addCommand("");
    }

    private int slotOf(String identifier) {     // we have to handle the temp variables
        if(identifier.equals(""))
            return this.temp_vars.get(this.temp_vars.size()-1);
        ArrayList <VarDeclaration> locals = new ArrayList<>(currentMethod.getArgs());
        locals.addAll(currentMethod.getLocalVars());
        for(int i = 0; i < locals.size(); i++)
            if(locals.get(i).getVarName().getName().equals(identifier))
                return i+1;
        return 0;
    }

    private void makeSlot() {
        this.temp_vars.add(this.temp_vars.get(this.temp_vars.size()-1)+1);
    }

    private void removeSlot() {
        this.temp_vars.remove(this.temp_vars.size()-1);
    }

    @Override
    public String visit(Program program) {      // done
        for(ClassDeclaration c : program.getClasses()) {
            this.currentClass = c;
            this.expressionTypeChecker.setCurrentClass(c);
            this.labelNum = 0;
            c.accept(this);
        }
        return null;
    }

    @Override
    public String visit(ClassDeclaration classDeclaration) {    // done
        createFile(classDeclaration.getClassName().getName());
        addCommand(".class public "+classDeclaration.getClassName().getName());
        if(classDeclaration.getParentClassName() == null)
            addCommand(".super java/lang/Object");
        else
            addCommand(".super "+classDeclaration.getParentClassName().getName());
        addCommand("");
        for(FieldDeclaration f : classDeclaration.getFields())
            f.accept(this);
        addCommand("");
        if(classDeclaration.getConstructor() == null)
            addDefaultConstructor();
        else {
            this.currentMethod = classDeclaration.getConstructor();
            this.expressionTypeChecker.setCurrentMethod(classDeclaration.getConstructor());
            this.temp_vars = new ArrayList<>();
            ConstructorDeclaration constructor = classDeclaration.getConstructor();
            this.temp_vars.add(constructor.getArgs().size() + constructor.getLocalVars().size());
            classDeclaration.getConstructor().accept(this);
        }
        for(MethodDeclaration m : classDeclaration.getMethods()) {
            this.currentMethod = m;
            this.expressionTypeChecker.setCurrentMethod(m);
            this.temp_vars = new ArrayList<>();
            this.temp_vars.add(m.getArgs().size() + m.getLocalVars().size());
            m.accept(this);
        }
        return null;
    }

    @Override
    public String visit(ConstructorDeclaration constructorDeclaration) {    // done
        if(this.currentClass.getClassName().getName().equals("Main"))
            addStaticMainMethod();
        if(constructorDeclaration.getArgs().size() != 0)
            addDefaultConstructor();
        this.visit((MethodDeclaration) constructorDeclaration);
        return null;
    }

    @Override
    public String visit(MethodDeclaration methodDeclaration) {  // done
        String argsSigniture = "";
        for(VarDeclaration v : methodDeclaration.getArgs())
            argsSigniture = argsSigniture.concat(makeTypeSignature(v.getType(), false));

        if(methodDeclaration.getMethodName().getName().equals(currentClass.getClassName().getName())) {
            addCommand(".method public <init>("+argsSigniture+")V");
            addCommand(".limit locals 128");
            addCommand(".limit stack 128");
            addCommand("aload_0");
            if(currentClass.getParentClassName() == null)
                addCommand("invokespecial java/lang/Object/<init>()V");
            else {
                String parentName = currentClass.getParentClassName().getName();
                addCommand("invokespecial "+parentName+"/<init>()V");
            }
            for(FieldDeclaration f : currentClass.getFields()) {
                addCommand("aload_0");
                initialize(f.getVarDeclaration().getType());
                String className = currentClass.getClassName().getName();
                String fieldName = f.getVarDeclaration().getVarName().getName();
                String signiture = makeTypeSignature(f.getVarDeclaration().getType(), false);
                addCommand("putfield "+className+"/"+fieldName+" "+signiture);
            }
            for (int i = 0; i < methodDeclaration.getLocalVars().size(); i++)
                methodDeclaration.getLocalVars().get(i).accept(this);
            for(Statement stmt: methodDeclaration.getBody()) {
                addCommand(";new Statement");
                stmt.accept(this);
            }
            addCommand("return");
            addCommand(".end method");
            addCommand("");
        } else {
            String methodName = methodDeclaration.getMethodName().getName();
            String returnSigniture = makeTypeSignature(methodDeclaration.getReturnType(), false);
            addCommand(".method public "+methodName+"("+argsSigniture+")"+returnSigniture);
            addCommand(".limit locals 128");
            addCommand(".limit stack 128");
            for (int i = 0; i < methodDeclaration.getLocalVars().size(); i++)
                methodDeclaration.getLocalVars().get(i).accept(this);
            for (Statement stmt : methodDeclaration.getBody()) {
                addCommand(";new Statement");
                stmt.accept(this);
            }
            if (!methodDeclaration.getDoesReturn())
                addCommand("return");
            addCommand(".end method");
            addCommand("");
        }
        return null;
    }

    @Override
    public String visit(FieldDeclaration fieldDeclaration) {        // done
        String name = fieldDeclaration.getVarDeclaration().getVarName().getName();
        String signiture = makeTypeSignature(fieldDeclaration.getVarDeclaration().getType(), false);
        addCommand(".field "+name + " " + signiture);
        return null;
    }

    @Override
    public String visit(VarDeclaration varDeclaration) {        // done
        initialize(varDeclaration.getType());
        int slot = slotOf(varDeclaration.getVarName().getName());
        addCommand("astore "+slot);
        return null;
    }

    @Override
    public String visit(AssignmentStmt assignmentStmt) {        // done
        BinaryExpression assignExpr = new BinaryExpression(assignmentStmt.getlValue(), assignmentStmt.getrValue(), BinaryOperator.assign);
        addCommand(assignExpr.accept(this));
        addCommand("pop");
        return null;
    }

    @Override
    public String visit(BlockStmt blockStmt) {      // done
        for (Statement stmt: blockStmt.getStatements()) {
            addCommand(";new inblock Statement");
            stmt.accept(this);
        }
        return null;
    }

    @Override
    public String visit(ConditionalStmt conditionalStmt) {  // done
        Expression condition = conditionalStmt.getCondition();
        Statement ifBody = conditionalStmt.getThenBody();
        Statement elseBody = conditionalStmt.getElseBody();
        String Else = "Label_"+getLable();
        String After = "Label_"+getLable();
        addCommand(condition.accept(this));
        addCommand("ldc 0");
        addCommand("if_icmpeq "+Else);
        if(ifBody != null)
            ifBody.accept(this);
        addCommand("goto "+After);
        addCommand(Else +":");
        if(elseBody != null)
            elseBody.accept(this);
        addCommand(After+":");
        return null;
    }

    @Override
    public String visit(MethodCallStmt methodCallStmt) {    // done
        this.expressionTypeChecker.setIsInMethodCallStmt(true);
        addCommand(methodCallStmt.getMethodCall().accept(this));
        this.expressionTypeChecker.setIsInMethodCallStmt(false);
        addCommand("pop");
        return null;
    }

    @Override
    public String visit(PrintStmt print) {  // done
        addCommand("getstatic java/lang/System/out Ljava/io/PrintStream;");
        Expression e = print.getArg();
        Type t = e.accept(this.expressionTypeChecker);
        addCommand(e.accept(this));
        String signiture = makeTypeSignature(t, true);
        addCommand("invokevirtual java/io/PrintStream/print("+signiture+")V");
        return null;
    }

    @Override
    public String visit(ReturnStmt returnStmt) {    // done I think
        Type type = returnStmt.getReturnedExpr().accept(expressionTypeChecker);
        if(currentMethod.getReturnType() instanceof NullType) {
            addCommand("return");
        }
        else {
            Expression exp = returnStmt.getReturnedExpr();
            addCommand(exp.accept(this));
            String temp = toNonpremitive(type);
            if(temp != null)
                addCommand(temp);
            addCommand("areturn");
        }
        return null;
    }

    @Override
    public String visit(BreakStmt breakStmt) {  // done
        String label = this.breaks.get(this.breaks.size()-1);
        addCommand("goto "+label);
        return null;
    }

    @Override
    public String visit(ContinueStmt continueStmt) {    // done
        String label = this.continues.get(this.continues.size()-1);
        addCommand("goto "+label);
        return null;
    }

    @Override
    public String visit(ForeachStmt foreachStmt) {
        String cont = "Label_"+getLable();
        String brk = "Label_"+getLable();
        String rest = "Label_"+getLable();
        this.breaks.add(brk);
        this.continues.add(cont);

        // initialization
        addCommand(";here our foreach starts");
        makeSlot();
        addCommand("ldc 0");
        addCommand("istore " + slotOf(""));

        // condition
        addCommand(rest+":");
        addCommand("iload " + slotOf(""));
        addCommand(foreachStmt.getList().accept(this));
        addCommand("getfield List/elements Ljava/util/ArrayList;");
        addCommand("invokevirtual java/util/ArrayList/size()I");
        addCommand("if_icmpge "+ brk );

        // updating identifier
        addCommand(foreachStmt.getList().accept(this));
        addCommand("iload " + slotOf(""));
        addCommand("invokevirtual List/getElement(I)Ljava/lang/Object;");
        Type t = ((ListType) foreachStmt.getList().accept(expressionTypeChecker)).getElementsTypes().get(0).getType();
        if(t instanceof IntType || t instanceof BoolType) {
            if(t instanceof IntType)
                addCommand("checkcast java/lang/Integer\n");
            else
                addCommand("checkcast java/lang/Boolean\n");
            //addCommand(toPremitive(t));
        }
        else if(t instanceof StringType)
            addCommand("checkcast java/lang/String\n");
        else if(t instanceof ListType)
            addCommand("checkcast List\n");
        else if(t instanceof FptrType)
            addCommand("checkcast Fptr\n");
        else if(t instanceof ClassType)
            addCommand("checkcast " + ((ClassType) t).getClassName().getName() + "\n");
        addCommand("astore " + slotOf(foreachStmt.getVariable().getName()));

        // body
        if(foreachStmt.getBody() !=  null)
            foreachStmt.getBody().accept(this);

        //updating
        addCommand(cont+":");
        addCommand("iload " + slotOf(""));
        addCommand("ldc 1");
        addCommand("iadd");
        addCommand("istore " + slotOf(""));
        addCommand("goto " + rest);
        addCommand(brk+":");

        this.breaks.remove(this.breaks.size()-1);
        this.continues.remove(this.continues.size()-1);
        removeSlot();
        addCommand(";end of foreach");
        return null;
    }

    @Override
    public String visit(ForStmt forStmt) {
        String cont = "Label_"+getLable();
        String brk = "Label_"+getLable();
        String rest = "Label_"+getLable();
        this.breaks.add(brk);
        this.continues.add(cont);

        if(forStmt.getInitialize() != null)
            forStmt.getInitialize().accept(this);
        addCommand(rest+":");
        if(forStmt.getCondition() != null)
            addCommand(forStmt.getCondition().accept(this));
        else
            addCommand("ldc 1");
        addCommand("ldc 0");
        addCommand("if_icmpeq "+brk);
        if(forStmt.getBody() != null)
            forStmt.getBody().accept(this);

        addCommand(cont+":");
        if(forStmt.getUpdate() != null)
            forStmt.getUpdate().accept(this);
        addCommand("goto "+rest);
        addCommand(brk+":");

        return null;
    }

    @Override
    public String visit(BinaryExpression binaryExpression) {
        String commands = "";
        BinaryOperator operator = binaryExpression.getBinaryOperator();
        Expression op1 = binaryExpression.getFirstOperand();
        Expression op2 = binaryExpression.getSecondOperand();
        if (operator == BinaryOperator.add) {
            commands += op1.accept(this);
            commands += op2.accept(this);
            commands += "iadd\n";
        }
        else if (operator == BinaryOperator.sub) {
            commands += op1.accept(this);
            commands += op2.accept(this);
            commands += "isub\n";
        }
        else if (operator == BinaryOperator.mult) {
            commands += op1.accept(this);
            commands += op2.accept(this);
            commands += "imul\n";
        }
        else if (operator == BinaryOperator.div) {
            commands += op1.accept(this);
            commands += op2.accept(this);
            commands += "idiv\n";
        }
        else if (operator == BinaryOperator.mod) {
            commands += op1.accept(this);
            commands += op2.accept(this);
            commands += "irem\n";
        }
        else if((operator == BinaryOperator.gt) || (operator == BinaryOperator.lt)) {
            commands += op1.accept(this);
            commands += op2.accept(this);
            String Else = "Label_"+getLable();
            String After = "Label_"+getLable();
            if (operator == BinaryOperator.gt)
                commands += "if_icmpgt " + Else + "\n";
            if (operator == BinaryOperator.lt)
                commands += "if_icmplt " + Else + "\n";
            commands += "ldc 0\n";
            commands += "goto " + After + "\n";
            commands += Else + ":" + "\n";
            commands += "ldc 1\n";
            commands += After + ":" + "\n";
        }
        else if((operator == BinaryOperator.eq) || (operator == BinaryOperator.neq)) {
            commands += op1.accept(this);
            commands += op2.accept(this);
            Type t1 = op1.accept(this.expressionTypeChecker);
            Type t2 = op2.accept(this.expressionTypeChecker);
            String Else = "Label_"+getLable();
            String After = "Label_"+getLable();
            if (t1 instanceof IntType || t1 instanceof BoolType) {
                if (operator == BinaryOperator.eq)
                    commands += "if_icmpeq " + Else + "\n";
                if (operator == BinaryOperator.neq)
                    commands += "if_icmpne " + Else + "\n";
                commands += "ldc 0\n";
                commands += "goto " + After + "\n";
                commands += Else + ":" + "\n";
                commands += "ldc 1\n";
                commands += After + ":" + "\n";
            } else {
                if (operator == BinaryOperator.eq)
                    commands += "if_acmpeq " + Else + "\n";
                if (operator == BinaryOperator.neq)
                    commands += "if_acmpne " + Else + "\n";
                commands += "ldc 0\n";
                commands += "goto " + After + "\n";
                commands += Else + ":" + "\n";
                commands += "ldc 1\n";
                commands += After + ":" + "\n";
            }
        }
        else if(operator == BinaryOperator.and) {
            String False = "Label_"+getLable();
            String After = "Lable_"+getLable();
            commands += op1.accept(this);
            commands += "ldc 0\n";
            commands += "if_icmpeq " + False + "\n";
            commands += op2.accept(this);
            commands += "ldc 0\n";
            commands += "if_icmpeq " + False + "\n";
            commands += "ldc 1\n";
            commands += "goto " + After + "\n";
            commands += False + ":\n";
            commands += "ldc 0\n";
            commands += After + ":\n";
        }
        else if(operator == BinaryOperator.or) {
            String True = "Label_"+getLable();
            String After = "Lable_"+getLable();
            commands += op1.accept(this);
            commands += "ldc 1\n";
            commands += "if_icmpeq " + True + "\n";
            commands += op2.accept(this);
            commands += "ldc 1\n";
            commands += "if_icmpeq " + True + "\n";
            commands += "ldc 0\n";
            commands += "goto " + After + "\n";
            commands += True + ":\n";
            commands += "ldc 1\n";
            commands += After + ":\n";
        }
        else if(operator == BinaryOperator.assign) {
            Type firstType = binaryExpression.getFirstOperand().accept(expressionTypeChecker);
            Type secondType = binaryExpression.getSecondOperand().accept(expressionTypeChecker);

            if(binaryExpression.getFirstOperand() instanceof Identifier) {
                commands += getSecondOpCommands(secondType, binaryExpression);
                String temp = toNonpremitive(secondType);
                String id = ((Identifier) binaryExpression.getFirstOperand()).getName();
                if(temp != null)
                    commands += temp;
                int slot = slotOf(id);
                commands += "astore " + slot + "\n";
                commands += binaryExpression.getFirstOperand().accept(this);
            }
            else if(binaryExpression.getFirstOperand() instanceof ListAccessByIndex) {
                ListAccessByIndex firstOperand = (ListAccessByIndex) binaryExpression.getFirstOperand();
                commands += firstOperand.getInstance().accept(this);
                commands += firstOperand.getIndex().accept(this);
                commands += getSecondOpCommands(secondType, binaryExpression);
                String temp = toNonpremitive(secondType);
                if(temp != null)
                    commands += temp;
                commands += "invokevirtual List/setElement(ILjava/lang/Object;)V\n";
                commands += binaryExpression.getFirstOperand().accept(this);
            }
            else if(binaryExpression.getFirstOperand() instanceof ObjectOrListMemberAccess) {
                Expression instance = ((ObjectOrListMemberAccess) binaryExpression.getFirstOperand()).getInstance();
                Type memberType = binaryExpression.getFirstOperand().accept(expressionTypeChecker);
                String memberName = ((ObjectOrListMemberAccess) binaryExpression.getFirstOperand()).getMemberName().getName();
                Type instanceType = instance.accept(expressionTypeChecker);
                if(instanceType instanceof ListType) {
                    ObjectOrListMemberAccess firstOperand = (ObjectOrListMemberAccess) binaryExpression.getFirstOperand();
                    commands += firstOperand.getInstance().accept(this);
                    int index = getIndex((ListType) instanceType, memberName);
                    commands += "ldc " + index + "\n";
                    commands += getSecondOpCommands(secondType, binaryExpression);
                    String temp = toNonpremitive(secondType);
                    if(temp != null)
                        commands += temp;
                    commands += "invokevirtual List/setElement(ILjava/lang/Object;)V\n";
                    commands += binaryExpression.getFirstOperand().accept(this);
                }
                else if(instanceType instanceof ClassType) {
                    ObjectOrListMemberAccess firstOperand = (ObjectOrListMemberAccess) binaryExpression.getFirstOperand();
                    String className = ((ClassType) instanceType).getClassName().getName();
                    commands += firstOperand.getInstance().accept(this);
                    commands += getSecondOpCommands(secondType, binaryExpression);
                    String temp = toNonpremitive(secondType);
                    if(temp != null)
                        commands += temp;
                    commands += "putfield " + className + "/" + memberName + " " + makeTypeSignature(memberType, false) + "\n";
                    commands += binaryExpression.getFirstOperand().accept(this);
                }
            }
        }
        return commands;
    }

    public String getSecondOpCommands(Type t, BinaryExpression binaryExpression) {
        String commands = "";
        String secondOperandCommands = binaryExpression.getSecondOperand().accept(this);
        if(t instanceof ListType) {
            commands += "new List\n";
            commands += "dup\n";
            commands += secondOperandCommands;
            commands += "invokespecial List/<init>(LList;)V\n";
        }
        else
            commands += secondOperandCommands;
        return commands;
    }

    @Override
    public String visit(UnaryExpression unaryExpression) {
        String commands = "";
        UnaryOperator operator = unaryExpression.getOperator();
        if(operator == UnaryOperator.minus) {
            commands += unaryExpression.getOperand().accept(this);
            commands += "ineg\n";
        }
        else if(operator == UnaryOperator.not) {
            String Else = "Label_"+getLable();
            String After = "Label_"+getLable();
            commands += unaryExpression.getOperand().accept(this);
            commands += "ldc 0\n";
            commands += "if_icmpeq " + Else + "\n";
            commands += "ldc 0\n";
            commands += "goto " + After + "\n";
            commands += Else + ":\n";
            commands += "ldc 1\n";
            commands += After + ":\n";
        }
        else if((operator == UnaryOperator.predec) || (operator == UnaryOperator.preinc)) {
            BinaryExpression r;
            if(operator == UnaryOperator.predec)
                r = new BinaryExpression(unaryExpression.getOperand(), new IntValue(1), BinaryOperator.sub);
            else
                r = new BinaryExpression(unaryExpression.getOperand(), new IntValue(1), BinaryOperator.add);
            BinaryExpression U = new BinaryExpression(unaryExpression.getOperand(), r, BinaryOperator.assign);
            commands += U.accept(this);
        }
        else if((operator == UnaryOperator.postdec) || (operator == UnaryOperator.postinc)) {
            commands += unaryExpression.getOperand().accept(this);
            BinaryExpression r;
            if(operator == UnaryOperator.postdec)
                r = new BinaryExpression(unaryExpression.getOperand(), new IntValue(1), BinaryOperator.sub);
            else
                r = new BinaryExpression(unaryExpression.getOperand(), new IntValue(1), BinaryOperator.add);
            BinaryExpression U = new BinaryExpression(unaryExpression.getOperand(), r, BinaryOperator.assign);
            commands += U.accept(this);
            commands += "pop\n";
        }
        return commands;
    }

    public int getIndex(ListType list, String name) {
        for(int i = 0; i < list.getElementsTypes().size(); i++) {
            ListNameType e = list.getElementsTypes().get(i);
            if(name.equals(e.getName().getName()))
                return i;
        }
        return 0;
    }

    @Override
    public String visit(ObjectOrListMemberAccess objectOrListMemberAccess) {        // done I think
        String commands = "";
        Type memberType = objectOrListMemberAccess.accept(expressionTypeChecker);
        Type instanceType = objectOrListMemberAccess.getInstance().accept(expressionTypeChecker);
        String memberName = objectOrListMemberAccess.getMemberName().getName();
        if(instanceType instanceof ClassType) {
            String className = ((ClassType) instanceType).getClassName().getName();
            try {
                SymbolTableItem classItem = SymbolTable.root.getItem(ClassSymbolTableItem.START_KEY + className, true);
                SymbolTable classSymbolTable = ((ClassSymbolTableItem) classItem).getClassSymbolTable();
                try {
                    SymbolTableItem fieldItem = classSymbolTable.getItem(FieldSymbolTableItem.START_KEY + memberName, true);
                    commands += objectOrListMemberAccess.getInstance().accept(this);
                    String fieldName = fieldItem.getName();
                    commands += "getfield " + className + "/" + fieldName + " " + makeTypeSignature(memberType, false) + "\n";
                    String temp = toPremitive(memberType);
                    if(temp != null)
                        commands += temp;

                } catch (ItemNotFoundException memberIsMethod) {
                    SymbolTableItem methodItem = classSymbolTable.getItem(MethodSymbolTableItem.START_KEY + memberName, true);
                    commands += "new Fptr\n";
                    commands += "dup\n";
                    commands += objectOrListMemberAccess.getInstance().accept(this);
                    commands += "ldc \"" + memberName + "\"\n";
                    commands += "invokespecial Fptr/<init>(Ljava/lang/Object;Ljava/lang/String;)V\n";
                }
            } catch (ItemNotFoundException classNotFound) {}
        }
        else if(instanceType instanceof ListType) {
            int index = getIndex((ListType) instanceType, memberName);
            commands += objectOrListMemberAccess.getInstance().accept(this);
            commands += "ldc " + index + "\n";
            commands += "invokevirtual List/getElement(I)Ljava/lang/Object;\n";
            if(memberType instanceof IntType || memberType instanceof BoolType) {
                if(memberType instanceof IntType)
                    commands += "checkcast java/lang/Integer\n";
                else
                    commands += "checkcast java/lang/Boolean\n";
                commands += toPremitive(memberType);
            }
            else if(memberType instanceof StringType)
                commands += "checkcast java/lang/String\n";
            else if(memberType instanceof ListType)
                commands += "checkcast List\n";
            else if(memberType instanceof FptrType)
                commands += "checkcast Fptr\n";
            else if(memberType instanceof ClassType)
                commands += "checkcast " + ((ClassType) memberType).getClassName().getName() + "\n";
        }
        return commands;
    }

    @Override
    public String visit(Identifier identifier) {    // done
        String commands = "";
        Type t = identifier.accept(this.expressionTypeChecker);
        int slot = slotOf(identifier.getName());
        commands += "aload " + slot + "\n";
        String temp = toPremitive(t);
        if(temp != null)
            commands += temp;
        return commands;
    }

    @Override
    public String visit(ListAccessByIndex listAccessByIndex) {
        String commands = "";
        Type memberType = listAccessByIndex.accept(this.expressionTypeChecker);
        commands += listAccessByIndex.getInstance().accept(this);
        commands += listAccessByIndex.getIndex().accept(this);
        commands += "invokevirtual List/getElement(I)Ljava/lang/Object;\n";
        if(memberType instanceof IntType || memberType instanceof BoolType) {
            if(memberType instanceof IntType)
                commands += "checkcast java/lang/Integer\n";
            else
                commands += "checkcast java/lang/Boolean\n";
            commands += toPremitive(memberType);
        }
        else if(memberType instanceof StringType)
            commands += "checkcast java/lang/String\n";
        else if(memberType instanceof ListType)
            commands += "checkcast List\n";
        else if(memberType instanceof FptrType)
            commands += "checkcast Fptr\n";
        else if(memberType instanceof ClassType)
            commands += "checkcast " + ((ClassType) memberType).getClassName().getName() + "\n";
        return commands;
    }

    @Override
    public String visit(MethodCall methodCall) {
        String commands = "";
        commands += methodCall.getInstance().accept(this);
        commands += "new java/util/ArrayList\n";
        commands += "dup\n";
        commands += "invokespecial java/util/ArrayList/<init>()V\n";
        for(Expression e : methodCall.getArgs()) {
            commands += "dup\n";
            commands += e.accept(this);
            String temp = toNonpremitive(e.accept(expressionTypeChecker));
            if(temp != null)
                commands += temp;
            commands += "invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z\n";
            commands += "pop\n";
        }
        commands += "invokevirtual Fptr/invoke(Ljava/util/ArrayList;)Ljava/lang/Object;\n";
        Type t = methodCall.accept(expressionTypeChecker);
        if(t instanceof IntType || t instanceof BoolType) {
            if(t instanceof IntType)
                commands += "checkcast java/lang/Integer\n";
            else
                commands += "checkcast java/lang/Boolean\n";
            commands += toPremitive(t);
        }
        else if(t instanceof StringType)
            commands += "checkcast java/lang/String\n";
        else if(t instanceof ListType)
            commands += "checkcast List\n";
        else if(t instanceof FptrType)
            commands += "checkcast Fptr\n";
        else if(t instanceof ClassType)
            commands += "checkcast " + ((ClassType) t).getClassName().getName() + "\n";
        return commands;
    }

    @Override
    public String visit(NewClassInstance newClassInstance) {        // done but not tested
        String commands = "";
        String signiture = "";
        commands += "new " + newClassInstance.getClassType().getClassName().getName() + "\n";
        commands += "dup\n";
        for(Expression e : newClassInstance.getArgs()) {
            commands += e.accept(this);
            String temp = toNonpremitive(e.accept(this.expressionTypeChecker));
            if(temp != null)
                commands += temp;
            signiture += makeTypeSignature(e.accept(this.expressionTypeChecker), false);
        }
        commands += "invokespecial "+newClassInstance.getClassType().getClassName().getName()+"/<init>("+signiture+")V\n";
        return commands;
    }

    @Override
    public String visit(ThisClass thisClass) {      // done but not tested
        String commands = "";
        commands += "aload_0\n";
        return commands;
    }

    @Override
    public String visit(ListValue listValue) {      // doen but not tested
        String commands = "";
        commands += "new List\n";
        commands += "dup\n";
        commands += "new java/util/ArrayList\n";
        commands += "dup\n";
        commands += "invokespecial java/util/ArrayList/<init>()V\n";
        for(Expression e : listValue.getElements()) {
            commands += "dup\n";
            commands += e.accept(this);
            String temp = toNonpremitive(e.accept(this.expressionTypeChecker));
            if(temp != null)
                commands += temp;
            commands += "checkcast java/lang/Object\n";
            commands += "invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z\n";
            commands += "pop\n";
        }
        commands += "invokespecial List/<init>(Ljava/util/ArrayList;)V\n";
        return commands;
    }

    @Override
    public String visit(NullValue nullValue) {  // done
        String commands = "";
        commands += "aconst_null\n";
        return commands;
    }

    @Override
    public String visit(IntValue intValue) {    // done
        String commands = "";
        commands += "ldc " + intValue.getConstant() + "\n";
        return commands;
    }

    @Override
    public String visit(BoolValue boolValue) {  // done
        String commands = "";
        if(boolValue.getConstant())
            commands += "ldc 1\n";
        else
            commands += "ldc 0\n";
        return commands;
    }

    @Override
    public String visit(StringValue stringValue) {  // done
        String commands = "";
        commands += "ldc \"" + stringValue.getConstant() + "\"\n";
        return commands;
    }

}