compile:
	valac --pkg gtk+-3.0 src/Main.vala src/App.vala src/Window.vala src/Contagem.vala -o executavel

build:
	meson build --prefix=/usr

translations: build
	cd build; ninja
	cd build; ninja com.gitlab.joaovitor123jv.pomotimer-pot #Generates translate files
	cd build; ninja com.gitlab.joaovitor123jv.pomotimer-update-po #Update translate files

install: build translations
	cd build; ninja install

executavel: compile

run: executavel
	./executavel
