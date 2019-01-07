
public class Contador
{
	int tempo;
	Gtk.Label label;

	public Contador ( Gtk.Label label, int tempo )
	{
		this.tempo = tempo;
		this.label = label;
	}

	public int run()
	{
		if( contando )
		{
			Thread.exit( 0 );
			return -1;
		}

		int tempo = this.tempo;
		string remainingTime = _("Remaining Time")
		for(tempo = this.tempo ; tempo > 0 ; tempo-=1)
		{
			if( encerrar )
			{
				encerrar = false;
				break;
			}
			this.label.set_text(@"\n$(remainingTime): $tempo\n");
			Thread.usleep(1000000);
		}

		this.label.set_text(@"\n$(remainingTime): $(this.tempo)\n");

		Thread.exit( 0 );
		return -1;
	}
}
