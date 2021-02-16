.class public C
.super java/lang/Object
		
.field c Ljava/lang/Integer;
		
.method public <init>()V
.limit locals 128
.limit stack 128
		aload_0
		invokespecial java/lang/Object/<init>()V
		aload_0
		ldc 0
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		putfield C/c Ljava/lang/Integer;
;new Statement
		aload_0
		ldc 5
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		putfield C/c Ljava/lang/Integer;
		aload_0
		getfield C/c Ljava/lang/Integer;
		invokevirtual java/lang/Integer/intValue()I
		pop
		return
.end method
		
.method public foo()Ljava/lang/Integer;
.limit locals 128
.limit stack 128
;new Statement
		ldc 2
		invokestatic java/lang/Integer/valueOf(I)Ljava/lang/Integer;
		areturn
.end method
		
.method public getC()LC;
.limit locals 128
.limit stack 128
;new Statement
		aload_0
		areturn
.end method
		
