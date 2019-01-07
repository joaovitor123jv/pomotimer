
public class Contador
{
	int tempo;
	Gtk.Label label;
	PomoTimer app;
	Gtk.ProgressBar progressBar;

	public Contador ( Gtk.Label label, int tempo, PomoTimer app, Gtk.ProgressBar progressBar )
	{
		this.tempo = tempo;
		this.label = label;
		this.app = app;
		this.progressBar = progressBar;
	}

	public int run()
	{
		if( contando )
		{
			Thread.exit( 0 );
			return -1;
		}
		contando = true;

		double progresso = 0.0;
		double passo = 1.0 / this.tempo;
		this.progressBar.set_fraction(progresso);

		int tempo = this.tempo;
		string remainingTime = _("Remaining Time");
		for(tempo = this.tempo ; tempo > 0 ; tempo-=1)
		{
			if( encerrar )
			{
				encerrar = false;
				break;
			}
			this.label.set_text(@"\n$remainingTime: $tempo\n");
			progresso += passo;
			this.progressBar.set_fraction(progresso);
			Thread.usleep(1000000);
		}
		contando = false;

		this.progressBar.set_fraction(0.0);
		this.label.set_text(@"\n$remainingTime: $(this.tempo)\n");

		var notificacao = new Notification(_("Time to pause ;-)"));
		notificacao.set_body(_("Take a break, your brain deserve this."));
		this.app.send_notification("notify.app", notificacao);

		Thread.exit( 0 );
		return -1;
	}
}
