.class public Main
.super java/lang/Object
		
		
;this is the added static main method
.method public static main([Ljava/lang/String;)V
.limit stack 128
.limit locals 128
		new Main
		invokespecial Main/<init>()V
		return
.end method
		
.method public <init>()V
.limit locals 128
.limit stack 128
		aload_0
		invokespecial java/lang/Object/<init>()V
		aconst_null
		astore 1
;new Statement
		new A
		dup
		ldc 1
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		ldc "hello"
		ldc 1
		invokestatic java/lang/Boolean/valueOf(Z)Ljava/lang/Boolean;
		invokespecial A/<init>(Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/Boolean;)V
		astore 1
		aload 1
		pop
		return
.end method
		
