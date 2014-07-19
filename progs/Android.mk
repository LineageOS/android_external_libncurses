LOCAL_PATH:= $(call my-dir)

progs_include := $(LOCAL_PATH)/../include $(LOCAL_PATH)/../ncurses

include $(CLEAR_VARS)

LOCAL_MODULE      := tic
LOCAL_MODULE_TAGS := debug
LOCAL_SRC_FILES   := $(LOCAL_MODULE).c dump_entry.c
LOCAL_C_INCLUDES  := $(progs_include)
LOCAL_SHARED_LIBRARIES := libncurses
LOCAL_LDFLAGS += -Wl,--no-fatal-warnings
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

LOCAL_MODULE      := toe
LOCAL_MODULE_TAGS := debug
LOCAL_SRC_FILES   := $(LOCAL_MODULE).c dump_entry.c
LOCAL_C_INCLUDES  := $(progs_include)
LOCAL_SHARED_LIBRARIES := libncurses
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

LOCAL_MODULE      := clear
LOCAL_MODULE_TAGS := debug
LOCAL_SRC_FILES   := $(LOCAL_MODULE).c
LOCAL_C_INCLUDES  := $(progs_include)
LOCAL_SHARED_LIBRARIES := libncurses
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

LOCAL_MODULE      := tput
LOCAL_MODULE_TAGS := debug
LOCAL_SRC_FILES   := $(LOCAL_MODULE).c
LOCAL_C_INCLUDES  := $(progs_include)
LOCAL_SHARED_LIBRARIES := libncurses
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

LOCAL_MODULE      := tset
LOCAL_MODULE_TAGS := debug
LOCAL_SRC_FILES   := $(LOCAL_MODULE).c
LOCAL_C_INCLUDES  := $(progs_include)
LOCAL_SHARED_LIBRARIES := libncurses
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

LOCAL_MODULE      := infocmp
LOCAL_MODULE_TAGS := debug
LOCAL_SRC_FILES   := $(LOCAL_MODULE).c dump_entry.c
LOCAL_C_INCLUDES  := $(progs_include)
LOCAL_SHARED_LIBRARIES := libncurses
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

LOCAL_MODULE := capconvert
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
LOCAL_SRC_FILES := $(LOCAL_MODULE)

include $(BUILD_PREBUILT)

