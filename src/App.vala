

public class PomoTimer : Gtk.Application
{
	GLib.Settings settings;

	// public Stage stage {get; set;}
	// public State state {get; set;}

	public int screenWidth { get; set;}
	public int screenHeight { get; set;}

	public int rowSpacing { get; set;}
	public int columnSpacing { get; set;}

	public int workTime { get; set;}
	public int restingTime {get; set;}
	public int shortPauseTime {get; set;}
	public int amountOfCicles {get; set;}


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
		this.restingTime = this.settings.get_int("resting-time");
		this.shortPauseTime = this.settings.get_int("short-pause-time");
		this.amountOfCicles = this.settings.get_int("amount-of-cicles");

		this.rowSpacing = this.settings.get_int("row-spacing");
		this.columnSpacing = this.settings.get_int("column-spacing");

		stage = Stage.START;
		state = State.STOPPED;

		// this.settings.bind( "window-width", x, "active", GLib.SettingsBindFlags.DEFAULT);
		print(@"Window Width = $(this.screenWidth)\n");
		print(@"Window Height = $(this.screenHeight)\n");
		print(@"Work time (minutes) = $(this.workTime/60)\n");
		print(@"Snap Time (minutes) = $(this.restingTime/60)\n");

		print(@"Row Spacing = $(this.rowSpacing)\n");
		print(@"Column Spacing = $(this.columnSpacing)\n");

		var mainWindow = new MainWindow(this);
		mainWindow.show();
	}
}

