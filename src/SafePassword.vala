class Undesktop.SafePassword : Gtk.Entry, Gtk.Buildable {
	public SafePassword () {
		this.draw.connect(draw_widget);
	}
	
	public void parser_finished (Gtk.Builder builder) {
		this.draw.connect(draw_widget);
	}

	public int dots = 10;
	public int spacing = 2;
	public bool dotsbar { get; set; default = false; }

	private float dot_width { get {
		return get_allocated_width() / dots;
	} }

	private void draw_dot (Cairo.Context cr, Gdk.RGBA color, float x, float y, float w, float h) {
		cr.set_source_rgba(color.red, color.green, color.blue, color.alpha);
		cr.rectangle(x+spacing, y, w-(spacing*2), h);
		cr.fill();
	}
	public bool draw_widget (Cairo.Context cr) {
		if (this.dotsbar) {
			// Get the colors
			var context = this.get_style_context();
			var state = this.get_state_flags();
			context.add_class(Gtk.STYLE_CLASS_PROGRESSBAR);
			Gdk.RGBA color_on = context.get_color(state);
			Gdk.RGBA color_off = context.get_background_color(state);
//			color_off.alpha = 0.3;

			// Get the text area
			Gdk.Rectangle rect;
			get_text_area(out rect);

			// Do the magic
			int filled = (int)text_length % dots;
			bool inverted = Math.floor((text_length / dots) % 2) != 1;

			// Loop through and magic
			for (int i = 0; i < dots; ++i) {
				float x = i * dot_width;
				bool on = inverted ? i < filled : i >= filled;

				draw_dot(cr,
							on ? color_on : color_off,
							rect.x + x, rect.y,
							dot_width, rect.height);
			}
			return true;
		} else {
			return false;
		}
	}
/*	public static int main (string[] args) {
		Gtk.init(ref args);
		var window = new Gtk.Window();
		var box = new Gtk.Box(Gtk.Orientation.VERTICAL, 2);
		window.add(box);
		var pass = new Undesktop.SafePassword();
		pass.dotsbar = true;
		box.add(pass);
		var pass2 = new Undesktop.SafePassword();
		box.add(pass2);
		window.show_all();
		window.destroy.connect(Gtk.main_quit);
		Gtk.main();
		return 0;
	}*/
}
