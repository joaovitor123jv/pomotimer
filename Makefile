compile:
	valac --pkg gtk+-3.0 src/Main.vala src/App.vala src/Window.vala src/Contador.vala -o executavel

build:
	meson build --prefix=/usr

translations: build
	cd build; ninja
	cd build; ninja com.github.joaovitor123jv.pomotimer-pot #Generates translate files
	cd build; ninja com.github.joaovitor123jv.pomotimer-update-po #Update translate files

install: build translations
	cd build; sudo ninja install
	sudo glib-compile-schemas /usr/share/glib-2.0/schemas/


executavel: compile

run: executavel
	./executavel
