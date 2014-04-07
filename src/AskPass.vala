namespace Undesktop {
	public class AskPass : Gtk.Dialog, Gtk.Buildable {
		public signal void password_entered (string password);
		public signal void password_cancelled ();

		private Gtk.Label _prompt;
		private SafePassword _input;
		private Gtk.Button _cancel_button;
		private Gtk.Button _okay_button;

		public static AskPass build () {
			// Build the interface
			var builder = new Gtk.Builder.from_resource("/org/Undesktop/AskPass/AskPass.ui");

			var askpass = (AskPass)builder.get_object("window");
			return askpass;
		}
		public void parser_finished (Gtk.Builder builder) {
			this._input = (SafePassword) builder.get_object("input");
			this._prompt = (Gtk.Label) builder.get_object("prompt");
			this._cancel_button = (Gtk.Button) builder.get_object("cancel_button");
			this._okay_button = (Gtk.Button) builder.get_object("okay_button");

			this.destroy.connect(() => { this.password_cancelled(); });
			this._cancel_button.clicked.connect(() => { this.password_cancelled(); });
			this._okay_button.clicked.connect(() => { this.password_entered(this._input.text); });
			this._input.activate.connect(() => { this.password_entered(this._input.text); });
		}
		public static AskPass build_with_prompt (string text) {
			var askpass = build();
			askpass._prompt.label = text;
			return askpass;
		}
	}
}
public static int main (string[] args) {
	Undesktop.AskPass askpass;
	string? password = null;

	Gtk.init(ref args);
	
	askpass = (args.length > 1) ? Undesktop.AskPass.build_with_prompt(args[1])
										 : Undesktop.AskPass.build();

	askpass.password_entered.connect((pwd) => {
		password = pwd;
		Gtk.main_quit();
	});
	askpass.password_cancelled.connect(() => {
		password = null;
		Gtk.main_quit();
	});
	askpass.show_all();

	Gtk.main();
	if (password == null) {
		return 1;
	} else {
		stdout.puts((string)password);
		return 0;
	}
}
