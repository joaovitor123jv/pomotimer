


public class PomoTimer : Gtk.Application
{
	GLib.Settings settings;
	public int screenWidth { get; set;}
	public int screenHeight { get; set;}
	public int rowSpacing { get; set;}
	public int columnSpacing { get; set;}
	public int workTime { get; set;}

	internal PomoTimer()
	{
		Object( application_id: "com.github.joaovitor123jv.pomotimer" );
	}

	protected override void activate()
	{
		this.settings = new GLib.Settings( "com.github.joaovitor123jv.pomotimer");
		// Gtk.Switch useless_switch = new Gtk.Switch();

		this.screenWidth = this.settings.get_int("window-width");
		this.screenHeight = this.settings.get_int("window-height");
		this.workTime = this.settings.get_int("work-time");
		this.rowSpacing = this.settings.get_int("row-spacing");
		this.columnSpacing = this.settings.get_int("column-spacing");


		// this.settings.bind( "window-width", x, "active", GLib.SettingsBindFlags.DEFAULT);
		// println(@"Window Width = $(this.screenWidth)");
		// println(@"Window Height = $(this.screenHeight)");
		// println(@"Work time = $(this.workTime)");
		// println(@"Row Spacing = $(this.rowSpacing)");

		var mainWindow = new MainWindow(this);
		mainWindow.show();
	}
}

// APLICAÇÂO
/*
public class Application : Gtk.Application
{
	protected override void activate()
	{
		new Window(this);
	}

	protected override void startup()
	{
		base.startup();

		var menu = new Menu();
		menu.append("Mensagem", "win.message");
		menu.append("Sair", "app.quit");
		this.app_menu = menu;

		var quit_action = new SimpleAction("quit", null);
		// quit_action.activate.connect( this.quit );
		this.add_action(quit_action);
	}

	public Application()
	{
		Object( application_id: "org.example.application" );
	}
} */
