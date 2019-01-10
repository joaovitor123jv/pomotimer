
// A window in the application
public class MainWindow : Gtk.ApplicationWindow
{
	PomoTimer app;

	// ***** Progress Bar(s)
	Gtk.ProgressBar progressBar; // Shows the progress of counting. where:
									// "empty" = "start of counting"
									// "full" = "finish of counting"

	// ***** Buttons
	Gtk.Button btConfig; // Configurations button.
	Gtk.Button btStart; // 3 functions: "start" (when not counting), "pause" (when counting), "continue" (when paused)
	Gtk.Button btStop; // 2 functions: "quit" (when not counting), and "stop" (when counting)



	// ***** Labels
	Gtk.Label lbTime;

	// ***** Times
	int restingTime; 	// Controls the max snap time, in seconds
					// Defaults: 900 seconds == 15 minutes, getted GLib.Settings

	int workTime; 	// Controls the max work time, in seconds
					// Defaults: 1500 seconds == 25 minutes, getted GLib.Settings

	int shortPauseTime; // Controls the short pause time, in seconds
						// Defaults: 300 seconds == 5 minutes, getted GLib.Settings

	int amountOfCicles; // Controls the amount of work cicles needed to reach the snap time
						// Defaults: 4, getted GLib.Settings


	public MainWindow( PomoTimer app )
	{
		Object( application: app, title: _("PomoTimer - A timer for the pomodoro method") );
		this.getAppData(app);
		this.window_position = Gtk.WindowPosition.CENTER;

		Gtk.Label lbAppTitle = new Gtk.Label(_("\nWelcome to PomoTimer!"));
		this.configureLabels( lbAppTitle );

		progressBar = new Gtk.ProgressBar();
		progressBar.set_fraction( 0.0 );
		progressBar.show();

		this.configureButtons();

		// Gtk.Grid settings
		Gtk.Grid grid = this.configureGrid( lbAppTitle );

		this.add(grid);

		grid.show();
		this.show_all();
	}

	private void getAppData( PomoTimer app )
	{
		this.app = app;
		this.set_default_size( app.screenWidth, app.screenHeight );
		this.restingTime = app.restingTime;
		// this.workTime = app.workTime;
		this.shortPauseTime = app.shortPauseTime;
		this.amountOfCicles = app.amountOfCicles;
	}

	private void configureLabels( Gtk.Label lbAppTitle )
	{
		string remainingTime = _("Remaining Time");
		lbTime = new Gtk.Label(@"\n$remainingTime: $(app.workTime)\n");
		lbTime.set_hexpand(true);
		lbAppTitle.set_hexpand(true);

	}

	private void configureButtons()
	{
		btConfig = new Gtk.Button.with_label(_("Settings"));
		btConfig.clicked.connect(this.showConfig);
		btConfig.set_hexpand(true);
		btConfig.show();

		btStart = new Gtk.Button.with_label(_("Start Timer"));
		btStart.clicked.connect(this.onStartButtonClick);
		btStart.set_hexpand(true);
		btStart.show();

		btStop = new Gtk.Button.with_label(_("Quit"));
		btStop.clicked.connect(this.onStopButtonClick);
		btStop.set_hexpand(true);
		btStop.show();
	}

	private Gtk.Grid configureGrid( Gtk.Label lbAppTitle )
	{
		Gtk.Grid grid = new Gtk.Grid();

		grid.row_spacing = this.app.rowSpacing; // Defaults: 6
		grid.column_spacing = this.app.columnSpacing; // Defaults: 6

		/* grid.attach( widget, horizontalCell, verticalCell, width, height ); */
		grid.attach( lbAppTitle, 0, 0, 4, 1 );
		grid.attach( this.lbTime, 0, 1, 4, 1 );
		grid.attach( this.btStart, 1, 2, 1, 1 );
		grid.attach( this.btStop, 2, 2, 1, 1 );
		grid.attach( this.btConfig, 3, 2, 1, 1);

		grid.attach( (new Gtk.Label("")), 1, 3, 3, 1 );

		grid.attach( this.progressBar, 1, 4, 3, 1 );

		return grid;
	}

	public void showConfig()
	{
		print(_("Show Configurations button pressed\n"));
		// progressBar.set_fraction(fraction);
		// if(fraction > 1.0)
		// {
		// 	progressBar.set_fraction(0.0);
		// }
	}

	public void onStartButtonClick()
	{
		if( threadStarted )
		{
			if( state == State.COUNTING )
			{
				state = State.PAUSED;
				btStart.set_label(_("Continue Counting"));
			}
			else
			{
				state = State.COUNTING;
				btStart.set_label(_("Pause Timer"));
			}
		}
		else // First run (starts counting thread)
		{
			var notificacao = new Notification(_("Time to start your work"));
			notificacao.set_body(_("Get hands on what you need to do!\n Focus! Focus! Focus!"));
			this.app.send_notification("notify.app", notificacao);

			state = State.COUNTING;
			stage = Stage.WORKING;


			btStop.set_label(_("Stop Timer"));
			btStart.set_label(_("Pause Timer"));

			try
			{
				print(_("Starting seconds counting\n"));
				Contador threadContagem = new Contador( this.lbTime, this.app, this.progressBar );
				Thread <int> thread = new Thread<int>.try("ThreadContagem", threadContagem.run);
			}
			catch( Error e )
			{
				print("ERROR: %s\n", e.message);
			}
			threadStarted = true;
		}
	}

	public void onStopButtonClick()
	{
		if( state == State.STOPPED )// Quitting APP
		{
			Process.exit(0);
		}
		else // Resetting counters
		{
			state = State.STOPPED;
			btStop.set_label(_("Quit"));
			btStart.set_label(_("Start Timer"));
		}
	}
}



