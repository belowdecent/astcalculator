class Lexer {
	var text:String;
	var pos:Int;
	var current_char_code:Null<Int>;

	public function new(text:String) {
		this.text = text;
		this.pos = 0;
		this.current_char_code = text.charCodeAt(pos);
	}

	function advanceCharCode() {
		pos += 1;
		current_char_code = text.charCodeAt(pos);
	}

	public function getNextToken():Token {
		var token = switch current_char_code {
			case ' '.code:
				while (current_char_code == ' '.code)
					advanceCharCode();
				getNextToken();
			case '+'.code:
				advanceCharCode();
				Token.Plus;
			case '-'.code:
				advanceCharCode();
				Token.Minus;
			case '/'.code:
				advanceCharCode();
				Token.Divide;
			case '*'.code:
				advanceCharCode();
				Token.Multiply;
			case '('.code:
				advanceCharCode();
				Token.ParenthesisOpen;
			case ')'.code:
				advanceCharCode();
				Token.ParenthesisClose;
			case digit = '0'.code | '1'.code | '2'.code | '3'.code | '4'.code | '5'.code | '6'.code | '7'.code | '8'.code | '9'.code:
				var value:Int = digit - 48;

				while (true) {
					advanceCharCode();
					switch current_char_code {
						case next_digit = '0'.code | '1'.code | '2'.code | '3'.code | '4'.code | '5'.code | '6'.code | '7'.code | '8'.code | '9'.code:
							value = value * 10 + next_digit - 48;
						case _:
							break;
					}
				}

				Token.Integer(value);
			case null:
				Token.EndOfFile;
			case catchall:
				throw new haxe.Exception('unknown symbol: ' + String.fromCharCode(catchall));
				null;
		}

		return token;
	}
}
