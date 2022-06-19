import haxe.io.Eof;

class Repl {
	static public function main() {
		var text:String;

		try {
			while (true) {
				Sys.print("calc> ");
				text = Sys.stdin().readLine();

				if (text == 'exit')
					break;

				if (text.length == 0)
					continue;

				var lexer = new Lexer(text);
				Sys.println("calc> " + new Parser(lexer).calculate());
			}
		} catch (e:Eof) {}
	}
}
