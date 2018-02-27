# Atom.io plugins
if command -v apm &>/dev/null; then
    apm install atom-beautify
    apm install autoclose-html
    apm install color-picker
	apm install file-icons
    apm install highlight-selected
    apm install language-babel
    apm install minimap
    apm install minimap-highlight-selected
    apm install multi-cursor
    apm install php-twig
    apm install pigments
    # theme
    apm install native-ui
    apm install one-dark-vivid-syntax

    cp $(dirname $0)/config.cson ~/.atom/config.cson
    cp $(dirname $0)/styles.less ~/.atom/styles.less
fi
