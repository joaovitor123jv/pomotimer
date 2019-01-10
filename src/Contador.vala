

public class Contador
{
	Gtk.Label lbTime;
	PomoTimer app;
	Gtk.ProgressBar progressBar;

	public Contador ( Gtk.Label lbTime, PomoTimer app, Gtk.ProgressBar progressBar )
	{
		this.lbTime = lbTime;
		this.app = app;
		this.progressBar = progressBar;
	}

	public int run()
	{
		if( threadStarted )// If somehow this thread can be called, this will stop it if already running
		{
			Thread.exit( 0 );
			return 0;
		}

		bool changeStage = false;
		int remainingTime = 0;
		int numberOfWorkingCicles = 0;
		double progress = 0.0;
		double step = (1.0 / this.app.workTime);
		string remainingTimeStr = _("Remaining Time");

		this.progressBar.set_fraction( progress );
		stdout.printf("Inicializando loop infinito\n");

		while( true )
		{
			if( changeStage )
			{
				stdout.printf("Mudança de estado detectada\n");
				if( (stage == Stage.WORKING) && (numberOfWorkingCicles >= app.amountOfCicles) )
				{
					stage = Stage.RESTING;
					remainingTime = app.restingTime;
					step = (1.0 / app.restingTime);
					progress = 0.0;
					this.progressBar.set_fraction(progress);
				}
				else if( stage == Stage.WORKING )
				{
					stage = Stage.SNAPPING;
					remainingTime = app.shortPauseTime;
					step = (1.0 / app.shortPauseTime);
					progress = 0.0;
					this.progressBar.set_fraction(progress);
				}
				else // stage == (Stage.SNAPPING or Stage.RESTING or Stage.START)
				{
					if( (state != State.PAUSED) || (stage == Stage.START) )
					{
						remainingTime = app.workTime;
						numberOfWorkingCicles = 1;
					}

					stage = Stage.WORKING;
					step = (1.0 / app.workTime);
					progress = 0.0;
					this.progressBar.set_fraction(progress);
				}
				changeStage = false;
			}
			else
			{
				while( (remainingTime > 0) && (state == State.COUNTING) )
				{
					string timeStr = this.formatTime(remainingTime);

					this.lbTime.set_text(@"\n$remainingTimeStr: $timeStr\n");
					progress += step;
					this.progressBar.set_fraction( progress );
					stdout.printf(" Contando\n");

					remainingTime -= 1;
					Thread.usleep(1000000); // Waits 1 second
				}

				while( state != State.COUNTING )
				{
					stdout.printf("Tá paradão\n");
					changeStage = true;
					Thread.usleep(100000); // Waits 1/10 second
				}

				if( stage == Stage.WORKING )
				{
					numberOfWorkingCicles += 1;
				}
				else if( stage == Stage.SNAPPING )
				{
					changeStage = true;
				}
				else // stage == Stage.RESTING
				{
					numberOfWorkingCicles = 1;
				}
			}

		}

		// for( time = this.app.workTime ; time > 0 ; time -= 1 )
		// {
		// 	if( stop )
		// 	{
		// 		stop = false;
		// 		break;
		// 	}
		// 	else if( pause )
		// 	{
		// 		// Adicionar coisas pra fazer aqui
		// 	}
		// 	else
		// 	{
		// 		this.lbTime.set_text(@"\n$remainingTime: $tempo\n");
		// 		progress += step;
		// 		this.progressBar.set_fraction( progress );
		// 	}

		// 	Thread.usleep(1000000); // Waits 1 second
		// }
		// contando = false;

		// this.progressBar.set_fraction(0.0);
		// this.label.set_text(@"\n$remainingTime: $(this.tempo)\n");

		// var notificacao = new Notification(_("Time to pause ;-)"));
		// notificacao.set_body(_("Take a break, your brain deserve this."));
		// this.app.send_notification("notify.app", notificacao);

		Thread.exit( 0 );
		return -1;
	}

	private string formatTime(int seconds)
	{
		int remainingSeconds = (seconds % 60);
		int minutes = (seconds - remainingSeconds)/60;

		return "%d:%d".printf(minutes, remainingSeconds);
	}

	private void sendNotification(string header, string text)
	{
		Notification notificacao = new Notification(_(header));
		notificacao.set_body(_(text));
		this.app.send_notification("notify.app", notificacao);
	}
}









