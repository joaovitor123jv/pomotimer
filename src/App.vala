


public class PomoTimer : Gtk.Application
{
	internal PomoTimer()
	{
		Object( application_id: "com.gitlab.joaovitor123jv.pomotimer" );
	}

	protected override void activate()
	{
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
