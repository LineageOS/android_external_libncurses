#!/bin/bash

OUT="Android.sources.bp"

SOURCE_FILES="\
    $(ls ncurses/base/*.c) \
    $(ls ncurses/tinfo/*.c) \
    $(ls ncurses/tty/*.c) \
    ncurses/codes.c \
    ncurses/comp_captab.c \
    ncurses/comp_userdefs.c \
    ncurses/expanded.c \
    ncurses/fallback.c \
    ncurses/lib_gen.c \
    ncurses/lib_keyname.c \
    ncurses/names.c \
    ncurses/unctrl.c \
    ncurses/trace/lib_trace.c \
    ncurses/trace/varargs.c \
    ncurses/trace/visbuf.c"

IGNORED_SOURCE_FILES="\
    ncurses/base/lib_driver.c \
    ncurses/base/sigaction.c \
    ncurses/tinfo/doalloc.c \
    ncurses/tinfo/make_keys.c \
    ncurses/tinfo/tinfo_driver.c"

# Copy only basic terminal type definitions as ncurses-base in debian does by default.
# https://salsa.debian.org/debian/ncurses/-/blob/master/debian/rules#L179
TERMINFO_FILES="\
	a/ansi c/cons25 c/cons25-debian c/cygwin d/dumb h/hurd l/linux \
	m/mach m/mach-bold m/mach-color m/mach-gnu m/mach-gnu-color p/pcansi \
	r/rxvt r/rxvt-basic \
	s/screen s/screen-256color s/screen-256color-bce s/screen-bce \
	s/screen-s s/screen-w s/screen.xterm-256color s/sun t/tmux \
	t/tmux-256color v/vt100 v/vt102 v/vt220 v/vt52 w/wsvt25 w/wsvt25m \
	x/xterm x/xterm-256color x/xterm-color x/xterm-mono \
	x/xterm-r5 x/xterm-r6 x/xterm-vt220 x/xterm-xfree86 E/Eterm \
	E/Eterm-color"

REQUIRED_MODULE_NAMES=()

cat << EOF > ${OUT}
// Autogenerated by gen_bp.sh, do not touch

filegroup {
    name: "libncurses_sources",
    srcs: [
EOF

for src in ${SOURCE_FILES}; do
    ignore=false
    for ignored_src in ${IGNORED_SOURCE_FILES}; do
        if [ "${src}" == "${ignored_src}" ]; then
            ignore=true
            break
        fi
    done
    if [ "${ignore}" == "true" ]; then
        continue
    fi
    echo "        \"${src}\"," >> ${OUT}
done

cat << EOF >> ${OUT}
    ],
}

EOF

for file in ${TERMINFO_FILES}; do
    MODULE_NAME=$(echo "libncurses_${file}" | tr '/' '_')
    REQUIRED_MODULE_NAMES+=("${MODULE_NAME}")
    echo "prebuilt_etc {
    name: \"${MODULE_NAME}\",
    src: \"lib/terminfo/${file}\",
    filename: "\"$(basename ${file})\"",
    relative_install_path: \"terminfo/$(dirname "${file}")\",
    product_specific: true,
    recovery_available: true,
}
" >> ${OUT}
done

cat << EOF >> ${OUT}
cc_defaults {
    name: "libncurses_etc_files",
    required: [
EOF

for module in "${REQUIRED_MODULE_NAMES[@]}"; do
    echo "        \"${module}\"," >> ${OUT}
done

cat << EOF >> ${OUT}
    ],
}

EOF

cat << EOF >> ${OUT}
cc_defaults {
    name: "libncurses_etc_files_recovery",
    required: [
EOF

for module in "${REQUIRED_MODULE_NAMES[@]}"; do
    echo "        \"${module}.recovery\"," >> ${OUT}
done

cat << EOF >> ${OUT}
    ],
}
EOF
