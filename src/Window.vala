
// A window in the application
public class MainWindow : Gtk.ApplicationWindow
{
	/* Gtk.Widget progressBar; */
	Gtk.ProgressBar progressBar;
	Gtk.Button btConfig;
	Gtk.Button btIniciar;
	Gtk.Button btParar;
	PomoTimer app;

	Gtk.Label lbTempo;

	int tempo;
	int tempoLimite;


	public MainWindow( PomoTimer app )
	{
		Object( application: app, title: _("PomoTimer - A pomodoro timer like app for elementary OS 5") );
		this.app = app;
		this.window_position = Gtk.WindowPosition.CENTER;
		this.set_default_size( app.screenWidth, app.screenHeight );

		tempo = 0;
		tempoLimite = app.workTime;
		print(@"Tempo Limite = $tempoLimite");

		Gtk.Label lbAppTitle = new Gtk.Label(_("\nWelcome to PomoTimer!"));
		lbAppTitle.set_hexpand(true);

		Gtk.Label lbVazio = new Gtk.Label("");

		string remainingTime = _("Remaining Time");

		lbTempo = new Gtk.Label(@"\n$remainingTime: $tempoLimite\n");
		lbTempo.set_hexpand(true);


		var grid = new Gtk.Grid();
		grid.row_spacing = app.rowSpacing;
		grid.column_spacing = app.columnSpacing;


		progressBar = new Gtk.ProgressBar();
		/* (progressBar as Gtk.ProgressBar).set_fraction( 0.0 ); */
		progressBar.set_fraction( 0.0 );

		progressBar.show();


		btConfig = new Gtk.Button.with_label(_("Settings"));
		btConfig.clicked.connect(this.mostrarConfiguracoes);
		btConfig.set_hexpand(true);
		btConfig.show();

		btIniciar = new Gtk.Button.with_label(_("Start Timer"));
		btIniciar.clicked.connect(this.iniciarContagem);
		btIniciar.set_hexpand(true);
		btIniciar.show();

		btParar = new Gtk.Button.with_label(_("Stop Timer"));
		btParar.clicked.connect(this.pararContagem);
		btParar.set_hexpand(true);
		btParar.show();

		/* Gtk.Separator separador = new Gtk.Separator( Gtk.Orientation.HORIZONTAL ); */

		this.add(grid);

		grid.attach( lbAppTitle, 0, 0, 4, 1 );
		grid.attach( lbTempo, 0, 1, 4, 1 );

		/* grid.attach( widget, celulaHorizontal, celulaVertical, tamanhoHorizontal, tamanhoVertical ); */

		grid.attach( btIniciar, 1, 2, 1, 1 );
		/* grid.attach( btParar, 1, 1, 1, 1 ); */
		grid.attach( btParar, 2, 2, 1, 1 );
		grid.attach( btConfig, 3, 2, 1, 1);

		grid.attach( lbVazio, 1, 3, 3, 1 );

		grid.attach( progressBar, 1, 4, 3, 1 );

		/* grid.attach_next_to(progressBar, lbAppTitle, Gtk.PositionType.BOTTOM, 1, 1); */
		grid.show();

		this.show_all();
	}

	public void mostrarConfiguracoes()
	{
		print(_("Show Configurations button pressed\n"));
		/* double fraction = (progressBar as Gtk.ProgressBar).get_fraction(); */
		double fraction = progressBar.get_fraction();
		fraction += 0.1;
		(progressBar as Gtk.ProgressBar).set_fraction(fraction);
		if(fraction > 1.0)
		{
			/* (progressBar as Gtk.ProgressBar).set_fraction(0.0); */
			progressBar.set_fraction(0.0);
		}
		/* (progressBar as Gtk.ProgressBar).pulse(); */
	}

	public void iniciarContagem()
	{
		var notificacao = new Notification(_("Time to start your work"));
		notificacao.set_body(_("Get hands on what you need to do!\n Focus! Focus! Focus!"));
		this.app.send_notification("notify.app", notificacao);
		try
		{
			print(_("Starting seconds counting\n"));
			Contador threadContagem = new Contador( this.lbTempo, this.tempoLimite, this.app, this.progressBar );
			Thread <int> thread = new Thread<int>.try("ThreadContagem", threadContagem.run);
		}
		catch( Error e )
		{
			print("ERROR: %s\n", e.message);
		}
	}

	public void pararContagem()
	{
		encerrar = !encerrar;
	}

}
