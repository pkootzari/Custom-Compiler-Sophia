.class public B
.super C
		
.field b Ljava/lang/Integer;
		
;this is a default constructor
.method public <init>()V
.limit locals 128
.limit stack 128
		aload 0
		invokespecial C/<init>()V
		aload_0
		ldc 0
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		putfield B/b Ljava/lang/Integer;
		return
.end method
		
.method public bar()Ljava/lang/Boolean;
.limit locals 128
.limit stack 128
;new Statement
		ldc 1
		ldc 1
		if_icmpeq Label_1
		ldc 0
		ldc 1
		if_icmpeq Label_1
		ldc 0
		goto Lable_2
		Label_1:
		ldc 1
		Lable_2:
		invokestatic java/lang/Boolean/valueOf(Z)Ljava/lang/Boolean;
		areturn
.end method
		
.method public getNewC()LC;
.limit locals 128
.limit stack 128
;new Statement
		new B
		dup
		invokespecial B/<init>()V
		areturn
.end method
		
