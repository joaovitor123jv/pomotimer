# project name and programming language
project('com.github.joaovitor123jv.pomotimer', 'vala', 'c', version: '0.1.0')

# Include the translations module
i18n = import('i18n')

# Set our translation domain
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')



# #Install our .desktop file so the Applications Menu will see it
# install_data(
#     join_paths('data', meson.project_name() + '.desktop'),
#     install_dir: join_paths(get_option('datadir'), 'applications')
# )

# #Install our .appdata.xml file so AppCenter will see it
# install_data(
#     join_paths('data', meson.project_name() + '.appdata.xml'),
#     install_dir: join_paths(get_option('datadir'), 'metainfo')
# )



install_data(
	'data/configuracoes.gschema.xml',
	install_dir: join_paths( get_option('datadir'), 'glib-2.0', 'schemas' ),
	rename: meson.project_name() + '.gschema.xml'
)

#Translate and install our .desktop file
i18n.merge_file(
    input: join_paths('data', meson.project_name() + '.desktop.in'),
    output: meson.project_name() + '.desktop',
    po_dir: join_paths(meson.source_root(), 'po'),
    type: 'desktop',
    install: true,
    install_dir: join_paths(get_option('datadir'), 'applications')
)

#Translate and install our .appdata file
i18n.merge_file(
    input: join_paths('data', meson.project_name() + '.appdata.xml.in'),
    output: meson.project_name() + '.appdata.xml',
    po_dir: join_paths(meson.source_root(), 'po'),
    install: true,
    install_dir: join_paths(get_option('datadir'), 'metainfo')
)


subdir('po')

# Parte dos icones
# message ('Adicionando pastas específicas na pasta do executavel')

# icon_sizes = ['128', '256']

# foreach i : icon_sizes
#     install_data(
#         join_paths('data/icons', i, meson.project_name() + '.svg'),
#         install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', i + 'x' + i, 'apps')
#     )
#     install_data(
#         join_paths('data/icons', i, meson.project_name() + '.svg'),
#         install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', i + 'x' + i + '@2', 'apps')
#     )
# endforeach


# Create a new executable, list the files we want to compile, list the dependencies we need, and install
executable(
    meson.project_name(),
    'src/Main.vala',
    'src/Contador.vala',
    'src/App.vala',
    'src/Window.vala',
    dependencies: [
        dependency('glib-2.0'),
        dependency('gtk+-3.0')
    ],
    install: true
)
