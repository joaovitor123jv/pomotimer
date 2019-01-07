using GLib;
using Gtk;

bool encerrar;
bool contando;

void println( string str )
{
	stdout.printf("%s\n", str);
}


int main( string[] args )
{
	encerrar = false;
	contando = false;
	if( Thread.supported() == false )
	{
		print(_("Threads aren\'t supported in this system\n"));
		return -1;
	}
	return new PomoTimer().run(args );
}


