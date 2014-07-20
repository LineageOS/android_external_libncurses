LOCAL_PATH:= $(call my-dir)

progs_include := $(LOCAL_PATH)/../include $(LOCAL_PATH)/../ncurses
widec_flags := -DUSE_WIDECHAR -DUSE_WIDEC_SUPPORT=1 -D_XOPEN_SOURCE_EXTENDED

include $(CLEAR_VARS)
LOCAL_MODULE      := test_inwstr
LOCAL_MODULE_TAGS := debug
LOCAL_SRC_FILES   := $(LOCAL_MODULE).c
LOCAL_C_INCLUDES  := $(progs_include)
LOCAL_SHARED_LIBRARIES := libncursesw
LOCAL_CFLAGS += $(widec_flags)
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE      := test_instr
LOCAL_MODULE_TAGS := debug
LOCAL_SRC_FILES   := $(LOCAL_MODULE).c
LOCAL_C_INCLUDES  := $(progs_include)
LOCAL_SHARED_LIBRARIES := libncurses
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE      := xmas
LOCAL_MODULE_TAGS := debug
LOCAL_SRC_FILES   := $(LOCAL_MODULE).c
LOCAL_C_INCLUDES  := $(progs_include)
LOCAL_SHARED_LIBRARIES := libncurses
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE      := demo_defkey
LOCAL_MODULE_TAGS := debug
LOCAL_SRC_FILES   := $(LOCAL_MODULE).c
LOCAL_C_INCLUDES  := $(progs_include)
LOCAL_SHARED_LIBRARIES := libncurses
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE      := test_addchstr
LOCAL_MODULE_TAGS := debug
LOCAL_SRC_FILES   := $(LOCAL_MODULE).c
LOCAL_C_INCLUDES  := $(progs_include)
LOCAL_SHARED_LIBRARIES := libncurses
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE      := test_add_wchstr
LOCAL_MODULE_TAGS := debug
LOCAL_SRC_FILES   := $(LOCAL_MODULE).c
LOCAL_C_INCLUDES  := $(progs_include)
LOCAL_SHARED_LIBRARIES := libncursesw
LOCAL_CFLAGS += $(widec_flags)
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE      := view
LOCAL_MODULE_TAGS := debug
LOCAL_SRC_FILES   := $(LOCAL_MODULE).c
LOCAL_C_INCLUDES  := $(progs_include)
LOCAL_SHARED_LIBRARIES := libncursesw
LOCAL_CFLAGS += $(widec_flags)
include $(BUILD_EXECUTABLE)

