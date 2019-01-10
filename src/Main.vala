using GLib;
using Gtk;

bool stop;
bool counting;
bool threadStarted;

enum State {
	COUNTING,
	PAUSED,
	STOPPED
}

enum Stage {
	WORKING,
	SNAPPING,
	RESTING,
	START
}

Stage stage;
State state;

void println( string str )
{
	stdout.printf("%s\n", str);
}


int main( string[] args )
{
	stop = false;
	counting = false;
	threadStarted = false;

	if( Thread.supported() == false )
	{
		print(_("Threads aren\'t supported in this system\n"));
		return -1;
	}
	print("Inicializando aplicativo\n");
	return new PomoTimer().run(args );
}


