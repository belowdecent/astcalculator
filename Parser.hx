import haxe.Exception;

class Parser {
	var lexer:Lexer;
	var current_token:Token;
	var root:ASTNode;

	public function new(lexer:Lexer) {
		this.lexer = lexer;
		this.current_token = this.lexer.getNextToken();
		this.root = expr();
	}

	public function calculate():Int {
		return eval(root);
	}

	function eval(node:ASTNode):Int {
		switch node {
			case ASTNode.Number(a):
				return a;
			case ASTNode.BinaryOperator(op, left, right):
				return op(eval(left), eval(right));
		}
	}

	function factor() {
		switch current_token {
			case Token.Integer(a):
				current_token = lexer.getNextToken();
				return ASTNode.Number(a);
			case Token.ParenthesisOpen:
				current_token = lexer.getNextToken();

				var node = expr();

				if (current_token != Token.ParenthesisClose)
					throw new Exception('Close your parenthesis!!!');

				current_token = lexer.getNextToken();
				return node;
			case _:
				throw new Exception('Integer not found! Got $current_token instead');
		};
	}

	function term():ASTNode {
		function div(a:Int, b:Int)
			return Math.round(a / b);

		function mul(a:Int, b:Int)
			return a * b;

		var node = factor();

		while ([Token.Divide, Token.Multiply].contains(current_token)) {
			var op:(Int, Int) -> Int = switch current_token {
				case Token.Divide:
					current_token = lexer.getNextToken();
					div;
				case Token.Multiply:
					current_token = lexer.getNextToken();
					mul;
				case _:
					throw new Exception('Operation not found! found: $current_token');
			};

			node = ASTNode.BinaryOperator(op, node, factor());
		}

		return node;
	}

	public function expr():ASTNode {
		function add(a:Int, b:Int)
			return a + b;

		function sub(a:Int, b:Int)
			return a - b;

		var node = term();

		while ([Token.Plus, Token.Minus].contains(current_token)) {
			var op:(Int, Int) -> Int = switch current_token {
				case Token.Plus:
					current_token = lexer.getNextToken();
					add;
				case Token.Minus:
					current_token = lexer.getNextToken();
					sub;
				case _:
					throw new Exception('Operation not found! found: $current_token');
			};

			node = ASTNode.BinaryOperator(op, node, term());
		}

		return node;
	}
}
