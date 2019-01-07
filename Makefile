compile:
	valac --pkg gtk+-3.0 src/main.vala src/app.vala src/window.vala src/contagem.vala -o executavel

executavel: compile

run: executavel
	./executavel
