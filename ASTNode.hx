enum ASTNode {
	BinaryOperator(operation:(Int, Int) -> Int, left:ASTNode, right:ASTNode);
	Number(value:Int);
}
