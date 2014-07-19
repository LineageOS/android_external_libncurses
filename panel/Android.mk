LOCAL_PATH:= $(call my-dir)

progs_include := $(LOCAL_PATH)/../include $(LOCAL_PATH)/../ncurses

include $(CLEAR_VARS)

srcdir =
pfiles := \
    $(srcdir)panel.c \
    $(srcdir)p_above.c \
    $(srcdir)p_below.c \
    $(srcdir)p_bottom.c \
    $(srcdir)p_delete.c \
    $(srcdir)p_hide.c \
    $(srcdir)p_hidden.c \
    $(srcdir)p_move.c \
    $(srcdir)p_new.c \
    $(srcdir)p_replace.c \
    $(srcdir)p_show.c \
    $(srcdir)p_top.c \
    $(srcdir)p_update.c \
    $(srcdir)p_user.c \
    $(srcdir)p_win.c

LOCAL_MODULE      := libpanel
LOCAL_MODULE_TAGS := debug
LOCAL_SRC_FILES   := $(pfiles)
LOCAL_C_INCLUDES  := $(progs_include)
LOCAL_CFLAGS += -DHAVE_CONFIG_H -U_XOPEN_SOURCE -D_XOPEN_SOURCE=500 -U_POSIX_C_SOURCE -D_POSIX_C_SOURCE=199506L
LOCAL_SHARED_LIBRARIES := libncurses
include $(BUILD_STATIC_LIBRARY)

