.class public A
.super B
		
.field cObj LC;
.field t LList;
.field e Ljava/lang/Integer;
		
;this is a default constructor
.method public <init>()V
.limit locals 128
.limit stack 128
		aload 0
		invokespecial B/<init>()V
		aload_0
		aconst_null
		putfield A/cObj LC;
		aload_0
		new List
		dup
		new java/util/ArrayList
		dup
		invokespecial java/util/ArrayList/<init>()V
		dup
		aconst_null
		invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z
		pop
		dup
		ldc 0
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z
		pop
		invokespecial List/<init>(Ljava/util/ArrayList;)V
		putfield A/t LList;
		aload_0
		ldc 0
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		putfield A/e Ljava/lang/Integer;
		return
.end method
		
.method public <init>(Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/Boolean;)V
.limit locals 128
.limit stack 128
		aload_0
		invokespecial B/<init>()V
		aload_0
		aconst_null
		putfield A/cObj LC;
		aload_0
		new List
		dup
		new java/util/ArrayList
		dup
		invokespecial java/util/ArrayList/<init>()V
		dup
		aconst_null
		invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z
		pop
		dup
		ldc 0
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z
		pop
		invokespecial List/<init>(Ljava/util/ArrayList;)V
		putfield A/t LList;
		aload_0
		ldc 0
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		putfield A/e Ljava/lang/Integer;
		ldc 0
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		astore 4
		new List
		dup
		new java/util/ArrayList
		dup
		invokespecial java/util/ArrayList/<init>()V
		dup
		new List
		dup
		new java/util/ArrayList
		dup
		invokespecial java/util/ArrayList/<init>()V
		dup
		ldc ""
		invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z
		pop
		dup
		ldc ""
		invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z
		pop
		invokespecial List/<init>(Ljava/util/ArrayList;)V
		invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z
		pop
		dup
		aconst_null
		invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z
		pop
		invokespecial List/<init>(Ljava/util/ArrayList;)V
		astore 5
		aconst_null
		astore 6
		new List
		dup
		new java/util/ArrayList
		dup
		invokespecial java/util/ArrayList/<init>()V
		dup
		ldc 0
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z
		pop
		dup
		ldc 0
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z
		pop
		dup
		ldc 0
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z
		pop
		dup
		ldc 0
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z
		pop
		dup
		ldc 0
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z
		pop
		dup
		ldc 0
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z
		pop
		dup
		ldc 0
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z
		pop
		dup
		ldc 0
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z
		pop
		dup
		ldc 0
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z
		pop
		dup
		ldc 0
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z
		pop
		invokespecial List/<init>(Ljava/util/ArrayList;)V
		astore 7
		aconst_null
		astore 8
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload 1
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload 2
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload 3
		invokevirtual java/lang/Boolean/booleanValue()Z
		invokevirtual java/io/PrintStream/print(Z)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload_0
		getfield A/b Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload_0
		getfield A/c Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		aload 5
		ldc 0
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast List
		ldc 0
		ldc "hi"
		invokevirtual List/setElement(ILjava/lang/Object;)V
		aload 5
		ldc 0
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast List
		ldc 0
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast java/lang/String
		pop
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload 5
		ldc 0
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast List
		ldc 0
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast java/lang/String
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload 5
		ldc 0
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast List
		ldc 1
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast java/lang/String
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload 5
		ldc 1
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast Fptr
		aconst_null
		if_acmpeq Label_1
		ldc 0
		goto Label_2
		Label_1:
		ldc 1
		Label_2:
		invokevirtual java/io/PrintStream/print(Z)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload 6
		aconst_null
		if_acmpeq Label_3
		ldc 0
		goto Label_4
		Label_3:
		ldc 1
		Label_4:
		invokevirtual java/io/PrintStream/print(Z)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		new Fptr
		dup
		aload_0
		ldc "foo"
		invokespecial Fptr/<init>(Ljava/lang/Object;Ljava/lang/String;)V
		astore 6
		aload 6
		pop
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload 6
		new java/util/ArrayList
		dup
		invokespecial java/util/ArrayList/<init>()V
		invokevirtual Fptr/invoke(Ljava/util/ArrayList;)Ljava/lang/Object;
		checkcast java/lang/Integer
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		new Fptr
		dup
		aload_0
		ldc "foo"
		invokespecial Fptr/<init>(Ljava/lang/Object;Ljava/lang/String;)V
		new java/util/ArrayList
		dup
		invokespecial java/util/ArrayList/<init>()V
		invokevirtual Fptr/invoke(Ljava/util/ArrayList;)Ljava/lang/Object;
		checkcast java/lang/Integer
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload_0
		getfield A/cObj LC;
		aconst_null
		if_acmpne Label_5
		ldc 0
		goto Label_6
		Label_5:
		ldc 1
		Label_6:
		invokevirtual java/io/PrintStream/print(Z)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		aload_0
		new C
		dup
		invokespecial C/<init>()V
		putfield A/cObj LC;
		aload_0
		getfield A/cObj LC;
		pop
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload_0
		getfield A/cObj LC;
		getfield C/c Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		aload_0
		getfield A/cObj LC;
		aload_0
		aload_0
		getfield A/c Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		ldc 1
		iadd
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		putfield A/c Ljava/lang/Integer;
		aload_0
		getfield A/c Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		ldc 4
		imul
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		putfield C/c Ljava/lang/Integer;
		aload_0
		getfield A/cObj LC;
		getfield C/c Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		pop
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload_0
		getfield A/cObj LC;
		getfield C/c Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload_0
		getfield A/c Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		new Fptr
		dup
		aload_0
		ldc "bar"
		invokespecial Fptr/<init>(Ljava/lang/Object;Ljava/lang/String;)V
		new java/util/ArrayList
		dup
		invokespecial java/util/ArrayList/<init>()V
		invokevirtual Fptr/invoke(Ljava/util/ArrayList;)Ljava/lang/Object;
		checkcast java/lang/Boolean
		invokevirtual java/lang/Boolean/booleanValue()Z
		ldc 0
		if_icmpeq Label_7
;new inblock Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "then"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new inblock Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
		goto Label_8
	Label_7:
;new inblock Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "else"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new inblock Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
	Label_8:
;new Statement
		ldc 0
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		astore 4
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		pop
	Label_11:
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		ldc 10
		if_icmplt Label_12
		ldc 0
		goto Label_13
		Label_12:
		ldc 1
		Label_13:
		ldc 0
		if_icmpeq Label_10
;new inblock Statement
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		ldc 5
		if_icmpne Label_18
		ldc 0
		goto Label_19
		Label_18:
		ldc 1
		Label_19:
		ldc 0
		if_icmpeq Label_16
		ldc 0
		goto Label_17
		Label_16:
		ldc 1
		Label_17:
		ldc 0
		if_icmpeq Label_14
		goto Label_10
		goto Label_15
	Label_14:
	Label_15:
;new inblock Statement
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		ldc 2
		if_icmpeq Label_22
		ldc 0
		goto Label_23
		Label_22:
		ldc 1
		Label_23:
		ldc 0
		if_icmpeq Label_20
		goto Label_9
		goto Label_21
	Label_20:
	Label_21:
;new inblock Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new inblock Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new inblock Statement
		aload 7
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		ldc 2
		imul
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		invokevirtual List/setElement(ILjava/lang/Object;)V
		aload 7
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast java/lang/Integer
		invokevirtual java/lang/Integer/intValue()I
		pop
	Label_9:
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		ldc 1
		iadd
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		astore 4
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		pop
		goto Label_11
	Label_10:
;new Statement
;here our foreach starts
		ldc 0
		istore 9
	Label_26:
		iload 9
		aload 7
		getfield List/elements Ljava/util/ArrayList;
		invokevirtual java/util/ArrayList/size()I
		if_icmpge Label_25
		aload 7
		iload 9
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast java/lang/Integer
		astore 4
;new inblock Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new inblock Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
	Label_24:
		iload 9
		ldc 1
		iadd
		istore 9
		goto Label_26
	Label_25:
;end of foreach
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload_0
		getfield A/e Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		aload_0
		ldc 7
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		putfield A/e Ljava/lang/Integer;
		aload_0
		getfield A/e Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		pop
;new Statement
		aload_0
		ldc 10
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		putfield A/c Ljava/lang/Integer;
		aload_0
		getfield A/c Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		pop
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload_0
		getfield A/e Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		new Fptr
		dup
		aload_0
		ldc "changeT"
		invokespecial Fptr/<init>(Ljava/lang/Object;Ljava/lang/String;)V
		astore 8
		aload 8
		pop
;new Statement
		aload 8
		new java/util/ArrayList
		dup
		invokespecial java/util/ArrayList/<init>()V
		dup
		new List
		dup
		new java/util/ArrayList
		dup
		invokespecial java/util/ArrayList/<init>()V
		dup
		aload_0
		checkcast java/lang/Object
		invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z
		pop
		dup
		ldc 9
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		checkcast java/lang/Object
		invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z
		pop
		invokespecial List/<init>(Ljava/util/ArrayList;)V
		invokevirtual java/util/ArrayList/add(Ljava/lang/Object;)Z
		pop
		invokevirtual Fptr/invoke(Ljava/util/ArrayList;)Ljava/lang/Object;
		pop
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload_0
		getfield A/t LList;
		ldc 1
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast java/lang/Integer
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload_0
		getfield A/t LList;
		ldc 0
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast C
		getfield C/c Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		new Fptr
		dup
		aload_0
		ldc "getNewC"
		invokespecial Fptr/<init>(Ljava/lang/Object;Ljava/lang/String;)V
		new java/util/ArrayList
		dup
		invokespecial java/util/ArrayList/<init>()V
		invokevirtual Fptr/invoke(Ljava/util/ArrayList;)Ljava/lang/Object;
		checkcast C
		getfield C/c Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		ldc 3
		aload_0
		getfield A/e Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		imul
		aload 7
		ldc 1
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast java/lang/Integer
		invokevirtual java/lang/Integer/intValue()I
		isub
		ldc 4
		irem
		new Fptr
		dup
		aload_0
		ldc "foo"
		invokespecial Fptr/<init>(Ljava/lang/Object;Ljava/lang/String;)V
		new java/util/ArrayList
		dup
		invokespecial java/util/ArrayList/<init>()V
		invokevirtual Fptr/invoke(Ljava/util/ArrayList;)Ljava/lang/Object;
		checkcast java/lang/Integer
		invokevirtual java/lang/Integer/intValue()I
		iadd
		new Fptr
		dup
		aload_0
		ldc "getNewC"
		invokespecial Fptr/<init>(Ljava/lang/Object;Ljava/lang/String;)V
		new java/util/ArrayList
		dup
		invokespecial java/util/ArrayList/<init>()V
		invokevirtual Fptr/invoke(Ljava/util/ArrayList;)Ljava/lang/Object;
		checkcast C
		getfield C/c Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		iadd
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		astore 4
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		pop
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		aload_0
		getfield A/t LList;
		ldc 0
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast C
		ldc 44
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		putfield C/c Ljava/lang/Integer;
		aload_0
		getfield A/t LList;
		ldc 0
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast C
		getfield C/c Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		pop
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload_0
		getfield A/t LList;
		ldc 0
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast C
		getfield C/c Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		ldc 1
		isub
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		astore 4
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		pop
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		ldc 1
		isub
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		astore 4
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		iadd
		ldc 3
		aload_0
		aload_0
		getfield A/e Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		ldc 1
		iadd
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		putfield A/e Ljava/lang/Integer;
		aload_0
		getfield A/e Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		imul
		aload 7
		ldc 1
		aload 7
		ldc 1
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast java/lang/Integer
		invokevirtual java/lang/Integer/intValue()I
		ldc 1
		isub
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		invokevirtual List/setElement(ILjava/lang/Object;)V
		aload 7
		ldc 1
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast java/lang/Integer
		invokevirtual java/lang/Integer/intValue()I
		isub
		ldc 4
		irem
		iadd
		new Fptr
		dup
		aload_0
		ldc "foo"
		invokespecial Fptr/<init>(Ljava/lang/Object;Ljava/lang/String;)V
		new java/util/ArrayList
		dup
		invokespecial java/util/ArrayList/<init>()V
		invokevirtual Fptr/invoke(Ljava/util/ArrayList;)Ljava/lang/Object;
		checkcast java/lang/Integer
		invokevirtual java/lang/Integer/intValue()I
		iadd
		new Fptr
		dup
		aload_0
		ldc "getNewC"
		invokespecial Fptr/<init>(Ljava/lang/Object;Ljava/lang/String;)V
		new java/util/ArrayList
		dup
		invokespecial java/util/ArrayList/<init>()V
		invokevirtual Fptr/invoke(Ljava/util/ArrayList;)Ljava/lang/Object;
		checkcast C
		getfield C/c Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		aload_0
		getfield A/t LList;
		ldc 0
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast C
		getfield C/c Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		aload_0
		getfield A/t LList;
		ldc 0
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast C
		aload_0
		getfield A/t LList;
		ldc 0
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast C
		getfield C/c Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		ldc 1
		isub
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		putfield C/c Ljava/lang/Integer;
		aload_0
		getfield A/t LList;
		ldc 0
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast C
		getfield C/c Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		pop
		imul
		aload_0
		getfield A/t LList;
		ldc 0
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast C
		aload_0
		getfield A/t LList;
		ldc 0
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast C
		getfield C/c Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		ldc 1
		isub
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		putfield C/c Ljava/lang/Integer;
		aload_0
		getfield A/t LList;
		ldc 0
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast C
		getfield C/c Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		imul
		iadd
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		astore 4
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		pop
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		ldc 1
		iadd
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		astore 4
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		ldc 1
		iadd
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		astore 4
		aload 4
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload_0
		getfield A/e Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload 7
		ldc 1
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast java/lang/Integer
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		aload_0
		getfield A/t LList;
		ldc 0
		invokevirtual List/getElement(I)Ljava/lang/Object;
		checkcast C
		getfield C/c Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc 10
		ldc 2
		idiv
		ldc 1
		ineg
		ldc 4
		imul
		ldc 3
		irem
		iadd
		invokevirtual java/io/PrintStream/print(I)V
;new Statement
		getstatic java/lang/System/out Ljava/io/PrintStream;
		ldc "\n"
		invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
		return
.end method
		
.method public changeT(LList;)V
.limit locals 128
.limit stack 128
;new Statement
		aload_0
		new List
		dup
		aload 1
		invokespecial List/<init>(LList;)V
		putfield A/t LList;
		aload_0
		getfield A/t LList;
		pop
		return
.end method
		
