#gedit src/systems/base/rect.cc

#src\systems\sdl\sdl_graphics_system.cc
#src\systems\sdl\texture.cc
#vendor\guichan\src\opengl\openglimage.cpp
#vendor\guichan\src\opengl\openglgraphics.cpp
#vendor\guichan\include\opengl\openglimage.hpp
#vendor\guichan\include\opengl\openglgraphics.hpp
#gedit src/systems/sdl/sdl_event_system.cc

# sudo apt install libboost-serialization-dev libboost-program-options-dev libboost-iostreams-dev libboost-filesystem-dev libboost-date-time-dev libboost-thread-dev 
###only for sdl1.2### sudo apt install libsdl1.2-dev libsdl-ttf2.0-dev libsdl-image1.2-dev libsdl-mixer1.2-dev
# sudo apt install libvorbis-dev libpng-dev libgtk2.0-dev libfreetype-dev pkg-config
# sudo apt install libsdl2-dev libsdl2-ttf-dev libsdl2-image-dev libsdl2-mixer-dev 

# sudo apt install libboost-serialization-dev 
# sudo apt install libboost-program-options-dev
# sudo apt install libboost-iostreams-dev 
# sudo apt install libboost-filesystem-dev
# sudo apt install libboost-date-time-dev
# sudo apt install libboost-thread-dev

# sudo apt install libsdl1.2-dev
# sudo apt install libsdl-ttf2.0-dev
# sudo apt install libsdl-image1.2-dev
# sudo apt install libsdl-mixer1.2-dev

# sudo apt install libsdl2-dev

# sudo apt install libgtk2.0-dev
# sudo apt install libpng-dev

# sudo apt install libfreetype-dev
# sudo apt install pkg-config


# 6==waveshare gpm2804, raspberry pi cm4
# 5==waveshare gpm280z2, raspberry pi zero2w
# 4==raspberry pi 4b 64bit, 1.18.1
# 3==trimui brick
# 2==trimui smart pro
# 1==miyoo a30
# 0==xubuntu 20.04 64bit
MIYOO:=0
GLES2:=1
#if GLES2=1, use gl4es and merge xyzz/rlvm Android version patches

############
#don't change these
SDL2:=1
NOGTK:=1
#if NOGTK==1, remove GTK+2.0 code
MINLIB:=0
#if MINLIB==1, remove OpenGL code
############

ifeq ($(MIYOO),6)
CC  := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc -march=armv7-a -mtune=cortex-a72 -mfpu=neon-vfpv4 -mfloat-abi=hard
CPP := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ -march=armv7-a -mtune=cortex-a72 -mfpu=neon-vfpv4 -mfloat-abi=hard
AR  := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-ar cru
RANLIB := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-ranlib
else ifeq ($(MIYOO),5)
CC  := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc -mcpu=cortex-a7 -mfpu=neon -mfloat-abi=hard
CPP := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ -mcpu=cortex-a7 -mfpu=neon -mfloat-abi=hard
AR  := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-ar cru
RANLIB := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-ranlib
else ifeq ($(MIYOO),4)
CC := gcc
CPP := g++
AR := ar cru
RANLIB := ranlib
else ifeq ($(MIYOO),2)
CC  := /home/wmt/work_trimui/aarch64-linux-gnu-7.5.0-linaro/bin/aarch64-linux-gnu-gcc
CPP := /home/wmt/work_trimui/aarch64-linux-gnu-7.5.0-linaro/bin/aarch64-linux-gnu-g++
AR  := /home/wmt/work_trimui/aarch64-linux-gnu-7.5.0-linaro/bin/aarch64-linux-gnu-ar cru
RANLIB := /home/wmt/work_trimui/aarch64-linux-gnu-7.5.0-linaro/bin/aarch64-linux-gnu-ranlib
else ifeq ($(MIYOO),1)
CC  := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc -marm -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard
CPP := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ -marm -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard
AR  := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-ar cru
RANLIB := /home/wmt/work_a30/gcc-linaro-7.5.0-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-ranlib
else
#CC  := gcc
#CXX := g++
#AR  := ar
CC := gcc
CPP := g++
AR := ar cru
#ar qc
RANLIB := ranlib
endif
RM := rm -rf

CCFLAGS :=

CCFLAGS += -g -O0 
#-Os

#for gl4es
#CCFLAGS += --ansi 
CCFLAGS += -std=c++11 
CCFLAGS += -pthread 
CCFLAGS += -funsigned-char 

CCFLAGS += -DHAVE_CONFIG_H 
CCFLAGS += -DENABLE_NLS 
CCFLAGS += -DNO_SDL_GLEXT 
CCFLAGS += -D_GNU_SOURCE=1 
CCFLAGS += -D_REENTRANT 
CCFLAGS += -DCASE_SENSITIVE_FILESYSTEM

ifeq ($(SDL2),1)
CCFLAGS += -DUSE_SDL2=1 
CCFLAGS += -DMIYOO
else
endif

ifeq ($(MINLIB),1)
CCFLAGS += -DMY_USE_MINLIB=1
else
endif

ifeq ($(NOGTK),1)
CCFLAGS += -DMY_USE_NO_GTK=1
else
endif

ifeq ($(GLES2),1)
CCFLAGS += -DMY_USE_GLES2=1
else
endif

CCFLAGS += -I. 
CCFLAGS += -Ibuild_include 
CCFLAGS += -Isrc 
CCFLAGS += -Ivendor 
CCFLAGS += -Ivendor/GLEW/include 
#CCFLAGS += -Ivendor/SDL_mixer/include 
#CCFLAGS += -Ivendor/SDL_mixer/include/SDL
CCFLAGS += -Ivendor/guichan/include 

ifeq ($(MIYOO),2)
CCFLAGS += -I/home/wmt/work_trimui/usr/include/
#CCFLAGS += -I/home/wmt/work_trimui/usr/include/SDL 
CCFLAGS += -I/home/wmt/work_trimui/usr/include/freetype2 
else ifeq ($(MIYOO),1)
CCFLAGS += 
else
#CCFLAGS += -I/usr/include/SDL 
CCFLAGS += -I/usr/include/freetype2 
endif


ifeq ($(NOGTK),1)
else
CCFLAGS += -I/usr/include/gtk-2.0 
#FIXME:gdkconfig.h
CCFLAGS += -I/usr/lib/i386-linux-gnu/gtk-2.0/include 
CCFLAGS += -I/usr/lib/x86_64-linux-gnu/gtk-2.0/include/

CCFLAGS += -I/usr/include/atk-1.0 
CCFLAGS += -I/usr/include/cairo 
CCFLAGS += -I/usr/include/gdk-pixbuf-2.0 
CCFLAGS += -I/usr/include/pango-1.0 
CCFLAGS += -I/usr/include/gio-unix-2.0 
CCFLAGS += -I/usr/include/glib-2.0 

#FIXME:glibconfig.h
CCFLAGS += -I/usr/lib/i386-linux-gnu/glib-2.0/include 
CCFLAGS += -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
endif

CCFLAGS += -I/usr/include/pixman-1 
CCFLAGS += -I/usr/include/libpng12 
CCFLAGS += -I/usr/include/harfbuzz 

#for boost
CCFLAGS += -Wno-deprecated-declarations
CCFLAGS += -ftemplate-depth-128 
CCFLAGS += -finline-functions 
CCFLAGS += -Wno-inline 
#CCFLAGS += -Wall 
CCFLAGS += -Wextra 
CCFLAGS += -Wno-long-long 
CCFLAGS += -Wno-variadic-macros 
CCFLAGS += -Wunused-function 
CCFLAGS += -pedantic 
CCFLAGS += -pthread 
CCFLAGS += -DBOOST_ALL_NO_LIB=1 
CCFLAGS += -DBOOST_DATE_TIME_STATIC_LINK 
CCFLAGS += -DDATE_TIME_INLINE 
CCFLAGS += -DNDEBUG
CCFLAGS += -DBOOST_SYSTEM_STATIC_LINK=1
CCFLAGS += -DBOOST_FILESYSTEM_STATIC_LINK=1
CCFLAGS += -DBOOST_IOSTREAMS_USE_DEPRECATED
CCFLAGS += -DBOOST_THREAD_BUILD_LIB=1 
CCFLAGS += -DBOOST_THREAD_DONT_USE_CHRONO 
CCFLAGS += -DBOOST_THREAD_POSIX 
CCFLAGS += -I./vendor/boost_1_55_0

#my added
CCFLAGS += -Wno-ignored-qualifiers

#for GL4ES
CCFLAGS += -DDEFAULT_ES=2 -DEGL_NO_X11 -DHAS_BACKTRACE -DNOX11 -DNO_GBM -DODROID -DSTATICLIB
CCFLAGS += -Ivendor/gl4es/include 
CCFLAGS += -Ivendor/gl4es/src/util 
CCFLAGS += -Ivendor/gl4es/src/glx  
CCFLAGS += -fvisibility=hidden
#my added
#CCFLAGS += -Wno-declaration-after-statement

LDFLAGS := 

LDFLAGS += -pthread 

#LDFLAGS += -L/usr/lib/i386-linux-gnu 
#LDFLAGS += -lboost_program_options 
#LDFLAGS += -lboost_serialization 
#LDFLAGS += -lboost_iostreams 
#LDFLAGS += -lboost_filesystem 
#LDFLAGS += -lboost_date_time 
#LDFLAGS += -lboost_thread 
#LDFLAGS += -lboost_system 
LDFLAGS += -lpthread 

ifeq ($(SDL2),1)
#FIXME:added
LDFLAGS += -lSDL2_mixer 
else
#FIXME:added
LDFLAGS += -lSDL_mixer 
endif

LDFLAGS += -logg 
LDFLAGS += -lvorbis 
LDFLAGS += -lvorbisfile 
ifeq ($(SDL2),1)
LDFLAGS += -lSDL2_ttf 
LDFLAGS += -lSDL2_image
else
LDFLAGS += -lSDL_ttf 
LDFLAGS += -lSDL_image
endif 
LDFLAGS += -lpng 
LDFLAGS += -lz 
#LDFLAGS += -lpng12

ifeq ($(MINLIB),1)
else
ifeq ($(GLES2),1)
LDFLAGS += -lGLESv2 -lEGL -ldl
else
LDFLAGS += -lGL 
LDFLAGS += -lGLU 
endif
endif

ifeq ($(SDL2),1)
LDFLAGS += -lSDL2 
else
LDFLAGS += -lSDL 
endif

ifeq ($(NOGTK),1)
else
LDFLAGS += -lgtk-x11-2.0 
LDFLAGS += -lgdk-x11-2.0 
LDFLAGS += -latk-1.0 
LDFLAGS += -lgio-2.0 
LDFLAGS += -lpangoft2-1.0 
LDFLAGS += -lpangocairo-1.0 
LDFLAGS += -lgdk_pixbuf-2.0 
LDFLAGS += -lcairo 
LDFLAGS += -lpango-1.0 
LDFLAGS += -lfontconfig 
LDFLAGS += -lgobject-2.0 
LDFLAGS += -lglib-2.0 
endif
LDFLAGS += -lfreetype

ifeq ($(MIYOO),2)
#trimui smart pro
LDFLAGS += -lmad -lbz2
LDFLAGS += -lIMGegl -lsrv_um -lusc -lglslcompiler -L/home/wmt/work_trimui/usr/lib
else
endif




LIBRLVM_OBJS := 

LIBRLVM_OBJS += src/base/notification_details.o 
LIBRLVM_OBJS += src/base/notification_registrar.o 
LIBRLVM_OBJS += src/base/notification_service.o 
LIBRLVM_OBJS += src/base/notification_source.o 
LIBRLVM_OBJS += src/effects/blind_effect.o 
LIBRLVM_OBJS += src/effects/effect.o 
LIBRLVM_OBJS += src/effects/effect_factory.o 
LIBRLVM_OBJS += src/effects/fade_effect.o 
LIBRLVM_OBJS += src/effects/scroll_on_scroll_off.o 
LIBRLVM_OBJS += src/effects/wipe_effect.o 
LIBRLVM_OBJS += src/encodings/codepage.o 
LIBRLVM_OBJS += src/encodings/cp932.o 
LIBRLVM_OBJS += src/encodings/cp936.o 
LIBRLVM_OBJS += src/encodings/cp949.o 
LIBRLVM_OBJS += src/encodings/han2zen.o 
LIBRLVM_OBJS += src/encodings/western.o 
LIBRLVM_OBJS += src/libreallive/archive.o 
LIBRLVM_OBJS += src/libreallive/bytecode.o 
LIBRLVM_OBJS += src/libreallive/compression.o 
LIBRLVM_OBJS += src/libreallive/expression.o 
LIBRLVM_OBJS += src/libreallive/filemap.o 
LIBRLVM_OBJS += src/libreallive/gameexe.o 
LIBRLVM_OBJS += src/libreallive/intmemref.o 
LIBRLVM_OBJS += src/libreallive/scenario.o 
LIBRLVM_OBJS += src/long_operations/button_object_select_long_operation.o 
LIBRLVM_OBJS += src/long_operations/load_game_long_operation.o 
LIBRLVM_OBJS += src/long_operations/pause_long_operation.o 
LIBRLVM_OBJS += src/long_operations/select_long_operation.o 
LIBRLVM_OBJS += src/long_operations/textout_long_operation.o 
LIBRLVM_OBJS += src/long_operations/wait_long_operation.o 
LIBRLVM_OBJS += src/long_operations/zoom_long_operation.o 
LIBRLVM_OBJS += src/machine/dump_scenario.o 
LIBRLVM_OBJS += src/machine/game_hacks.o 
LIBRLVM_OBJS += src/machine/general_operations.o 
LIBRLVM_OBJS += src/machine/long_operation.o 
LIBRLVM_OBJS += src/machine/mapped_rlmodule.o 
LIBRLVM_OBJS += src/machine/memory.o 
LIBRLVM_OBJS += src/machine/memory_intmem.o 
LIBRLVM_OBJS += src/machine/opcode_log.o 
LIBRLVM_OBJS += src/machine/rlmachine.o 
LIBRLVM_OBJS += src/machine/rlmodule.o 
LIBRLVM_OBJS += src/machine/rloperation.o 
LIBRLVM_OBJS += src/machine/reallive_dll.o 
LIBRLVM_OBJS += src/machine/save_game_header.o 
LIBRLVM_OBJS += src/machine/serialization_global.o 
LIBRLVM_OBJS += src/machine/serialization_local.o 
LIBRLVM_OBJS += src/machine/stack_frame.o 
LIBRLVM_OBJS += src/machine/reference.o 
LIBRLVM_OBJS += src/modules/object_mutator_operations.o 
LIBRLVM_OBJS += src/modules/module_bgm.o 
LIBRLVM_OBJS += src/modules/module_bgr.o 
LIBRLVM_OBJS += src/modules/module_dll.o 
LIBRLVM_OBJS += src/modules/module_debug.o 
LIBRLVM_OBJS += src/modules/module_event_loop.o 
LIBRLVM_OBJS += src/modules/module_g00.o 
LIBRLVM_OBJS += src/modules/module_gan.o 
LIBRLVM_OBJS += src/modules/module_grp.o 
LIBRLVM_OBJS += src/modules/module_jmp.o 
LIBRLVM_OBJS += src/modules/module_koe.o 
LIBRLVM_OBJS += src/modules/module_mem.o 
LIBRLVM_OBJS += src/modules/module_mov.o 
LIBRLVM_OBJS += src/modules/module_msg.o 
LIBRLVM_OBJS += src/modules/module_obj.o 
LIBRLVM_OBJS += src/modules/module_obj_creation.o 
LIBRLVM_OBJS += src/modules/module_obj_fg_bg.o 
LIBRLVM_OBJS += src/modules/module_obj_management.o 
LIBRLVM_OBJS += src/modules/module_obj_getters.o 
LIBRLVM_OBJS += src/modules/module_os.o 
LIBRLVM_OBJS += src/modules/module_pcm.o 
LIBRLVM_OBJS += src/modules/module_refresh.o 
LIBRLVM_OBJS += src/modules/module_scr.o 
LIBRLVM_OBJS += src/modules/module_se.o 
LIBRLVM_OBJS += src/modules/module_sel.o 
LIBRLVM_OBJS += src/modules/module_shk.o 
LIBRLVM_OBJS += src/modules/module_shl.o 
LIBRLVM_OBJS += src/modules/module_str.o 
LIBRLVM_OBJS += src/modules/module_sys.o 
LIBRLVM_OBJS += src/modules/module_sys_date.o 
LIBRLVM_OBJS += src/modules/module_sys_frame.o 
LIBRLVM_OBJS += src/modules/module_sys_name.o 
LIBRLVM_OBJS += src/modules/module_sys_save.o 
LIBRLVM_OBJS += src/modules/module_sys_syscom.o 
LIBRLVM_OBJS += src/modules/module_sys_timer.o 
LIBRLVM_OBJS += src/modules/module_sys_wait.o 
LIBRLVM_OBJS += src/modules/module_sys_index_series.o 
LIBRLVM_OBJS += src/modules/module_sys_timetable2.o 
LIBRLVM_OBJS += src/modules/modules.o 
LIBRLVM_OBJS += src/modules/object_module.o 
LIBRLVM_OBJS += src/systems/base/anm_graphics_object_data.o 
LIBRLVM_OBJS += src/systems/base/cgm_table.o 
LIBRLVM_OBJS += src/systems/base/colour.o 
LIBRLVM_OBJS += src/systems/base/colour_filter_object_data.o 
LIBRLVM_OBJS += src/systems/base/digits_graphics_object.o 
LIBRLVM_OBJS += src/systems/base/drift_graphics_object.o 
LIBRLVM_OBJS += src/systems/base/event_listener.o 
LIBRLVM_OBJS += src/systems/base/event_system.o 
LIBRLVM_OBJS += src/systems/base/frame_counter.o 
LIBRLVM_OBJS += src/systems/base/gan_graphics_object_data.o 
LIBRLVM_OBJS += src/systems/base/graphics_object.o 
LIBRLVM_OBJS += src/systems/base/graphics_object_data.o 
LIBRLVM_OBJS += src/systems/base/graphics_object_of_file.o 
LIBRLVM_OBJS += src/systems/base/graphics_stack_frame.o 
LIBRLVM_OBJS += src/systems/base/graphics_system.o 
LIBRLVM_OBJS += src/systems/base/graphics_text_object.o 
LIBRLVM_OBJS += src/systems/base/hik_renderer.o 
LIBRLVM_OBJS += src/systems/base/hik_script.o 
LIBRLVM_OBJS += src/systems/base/koepac_voice_archive.o 
LIBRLVM_OBJS += src/systems/base/little_busters_ef00dll.o 
LIBRLVM_OBJS += src/systems/base/little_busters_pt00dll.o 
LIBRLVM_OBJS += src/systems/base/mouse_cursor.o 
LIBRLVM_OBJS += src/systems/base/nwk_voice_archive.o 
LIBRLVM_OBJS += src/systems/base/object_mutator.o 
LIBRLVM_OBJS += src/systems/base/object_settings.o 
LIBRLVM_OBJS += src/systems/base/ovk_voice_archive.o 
LIBRLVM_OBJS += src/systems/base/ovk_voice_sample.o 
LIBRLVM_OBJS += src/systems/base/parent_graphics_object_data.o 
LIBRLVM_OBJS += src/systems/base/platform.o 
LIBRLVM_OBJS += src/systems/base/rltimer.o 
LIBRLVM_OBJS += src/systems/base/rlbabel_dll.o 
LIBRLVM_OBJS += src/systems/base/rect.o 
LIBRLVM_OBJS += src/systems/base/selection_element.o 
LIBRLVM_OBJS += src/systems/base/sound_system.o 
LIBRLVM_OBJS += src/systems/base/surface.o 
LIBRLVM_OBJS += src/systems/base/system.o 
LIBRLVM_OBJS += src/systems/base/system_error.o 
LIBRLVM_OBJS += src/systems/base/text_key_cursor.o 
LIBRLVM_OBJS += src/systems/base/text_page.o 
LIBRLVM_OBJS += src/systems/base/text_system.o 
LIBRLVM_OBJS += src/systems/base/text_waku.o 
LIBRLVM_OBJS += src/systems/base/text_waku_normal.o 
LIBRLVM_OBJS += src/systems/base/text_waku_type4.o 
LIBRLVM_OBJS += src/systems/base/text_window.o 
LIBRLVM_OBJS += src/systems/base/text_window_button.o 
LIBRLVM_OBJS += src/systems/base/tomoyo_after_dt00dll.o 
LIBRLVM_OBJS += src/systems/base/tone_curve.o 
LIBRLVM_OBJS += src/systems/base/voice_archive.o 
LIBRLVM_OBJS += src/systems/base/voice_cache.o 
LIBRLVM_OBJS += src/utilities/exception.o 
LIBRLVM_OBJS += src/utilities/file.o 
LIBRLVM_OBJS += src/utilities/graphics.o 
LIBRLVM_OBJS += src/utilities/string_utilities.o 
LIBRLVM_OBJS += src/utilities/date_util.o 
LIBRLVM_OBJS += src/utilities/find_font_file.o 
LIBRLVM_OBJS += src/utilities/math_util.o 
LIBRLVM_OBJS += vendor/xclannad/endian.o 
LIBRLVM_OBJS += vendor/xclannad/file.o 
LIBRLVM_OBJS += vendor/xclannad/koedec_ogg.o 
LIBRLVM_OBJS += vendor/xclannad/nwatowav.o 
LIBRLVM_OBJS += vendor/xclannad/wavfile.o

LIBGUICHAN_PLATFORM_OBJS := 

LIBGUICHAN_PLATFORM_OBJS += src/platforms/gcn/gcn_button.o 
LIBGUICHAN_PLATFORM_OBJS += src/platforms/gcn/gcn_graphics.o 
LIBGUICHAN_PLATFORM_OBJS += src/platforms/gcn/gcn_info_window.o 
LIBGUICHAN_PLATFORM_OBJS += src/platforms/gcn/gcn_menu.o 
LIBGUICHAN_PLATFORM_OBJS += src/platforms/gcn/gcn_platform.o 
LIBGUICHAN_PLATFORM_OBJS += src/platforms/gcn/gcn_save_load_window.o 
LIBGUICHAN_PLATFORM_OBJS += src/platforms/gcn/gcn_scroll_area.o 
LIBGUICHAN_PLATFORM_OBJS += src/platforms/gcn/gcn_true_type_font.o 
LIBGUICHAN_PLATFORM_OBJS += src/platforms/gcn/gcn_utils.o 
LIBGUICHAN_PLATFORM_OBJS += src/platforms/gcn/gcn_window.o

LIBGUICHAN_OBJS := 

LIBGUICHAN_OBJS += vendor/guichan/src/sdl/sdlgraphics.o 
LIBGUICHAN_OBJS += vendor/guichan/src/sdl/sdlimageloader.o 
LIBGUICHAN_OBJS += vendor/guichan/src/sdl/sdlimage.o 
LIBGUICHAN_OBJS += vendor/guichan/src/sdl/sdlinput.o 
LIBGUICHAN_OBJS += vendor/guichan/src/sdl/sdl.o 
LIBGUICHAN_OBJS += vendor/guichan/src/rectangle.o 
LIBGUICHAN_OBJS += vendor/guichan/src/color.o 
LIBGUICHAN_OBJS += vendor/guichan/src/font.o 
LIBGUICHAN_OBJS += vendor/guichan/src/selectionevent.o 
LIBGUICHAN_OBJS += vendor/guichan/src/focushandler.o 
LIBGUICHAN_OBJS += vendor/guichan/src/cliprectangle.o 
LIBGUICHAN_OBJS += vendor/guichan/src/opengl/opengl.o 
LIBGUICHAN_OBJS += vendor/guichan/src/opengl/openglgraphics.o 
LIBGUICHAN_OBJS += vendor/guichan/src/opengl/openglimage.o 
LIBGUICHAN_OBJS += vendor/guichan/src/keyinput.o 
LIBGUICHAN_OBJS += vendor/guichan/src/key.o 
LIBGUICHAN_OBJS += vendor/guichan/src/actionevent.o 
LIBGUICHAN_OBJS += vendor/guichan/src/event.o 
LIBGUICHAN_OBJS += vendor/guichan/src/exception.o 
LIBGUICHAN_OBJS += vendor/guichan/src/graphics.o 
LIBGUICHAN_OBJS += vendor/guichan/src/guichan.o 
LIBGUICHAN_OBJS += vendor/guichan/src/mouseinput.o 
LIBGUICHAN_OBJS += vendor/guichan/src/keyevent.o 
LIBGUICHAN_OBJS += vendor/guichan/src/mouseevent.o 
LIBGUICHAN_OBJS += vendor/guichan/src/image.o 
LIBGUICHAN_OBJS += vendor/guichan/src/imagefont.o 
LIBGUICHAN_OBJS += vendor/guichan/src/defaultfont.o 
LIBGUICHAN_OBJS += vendor/guichan/src/genericinput.o 
LIBGUICHAN_OBJS += vendor/guichan/src/gui.o 
LIBGUICHAN_OBJS += vendor/guichan/src/widgets/window.o 
LIBGUICHAN_OBJS += vendor/guichan/src/widgets/label.o 
LIBGUICHAN_OBJS += vendor/guichan/src/widgets/checkbox.o 
LIBGUICHAN_OBJS += vendor/guichan/src/widgets/slider.o 
LIBGUICHAN_OBJS += vendor/guichan/src/widgets/button.o 
LIBGUICHAN_OBJS += vendor/guichan/src/widgets/radiobutton.o 
LIBGUICHAN_OBJS += vendor/guichan/src/widgets/imagebutton.o 
LIBGUICHAN_OBJS += vendor/guichan/src/widgets/container.o 
LIBGUICHAN_OBJS += vendor/guichan/src/widgets/scrollarea.o 
LIBGUICHAN_OBJS += vendor/guichan/src/widgets/dropdown.o 
LIBGUICHAN_OBJS += vendor/guichan/src/widgets/tabbedarea.o 
LIBGUICHAN_OBJS += vendor/guichan/src/widgets/textbox.o 
LIBGUICHAN_OBJS += vendor/guichan/src/widgets/listbox.o 
LIBGUICHAN_OBJS += vendor/guichan/src/widgets/tab.o 
LIBGUICHAN_OBJS += vendor/guichan/src/widgets/textfield.o 
LIBGUICHAN_OBJS += vendor/guichan/src/widgets/icon.o 
LIBGUICHAN_OBJS += vendor/guichan/src/basiccontainer.o 
LIBGUICHAN_OBJS += vendor/guichan/src/inputevent.o 
LIBGUICHAN_OBJS += vendor/guichan/src/widget.o

LIBSYSTEM_SDL_OBJS := 

LIBSYSTEM_SDL_OBJS += src/systems/sdl/sdl_audio_locker.o 
LIBSYSTEM_SDL_OBJS += src/systems/sdl/sdl_colour_filter.o 
LIBSYSTEM_SDL_OBJS += src/systems/sdl/sdl_event_system.o 
LIBSYSTEM_SDL_OBJS += src/systems/sdl/sdl_graphics_system.o 
LIBSYSTEM_SDL_OBJS += src/systems/sdl/sdl_music.o 
LIBSYSTEM_SDL_OBJS += src/systems/sdl/sdl_render_to_texture_surface.o 
LIBSYSTEM_SDL_OBJS += src/systems/sdl/sdl_sound_chunk.o 
LIBSYSTEM_SDL_OBJS += src/systems/sdl/sdl_sound_system.o 
LIBSYSTEM_SDL_OBJS += src/systems/sdl/sdl_surface.o 
LIBSYSTEM_SDL_OBJS += src/systems/sdl/sdl_system.o 
LIBSYSTEM_SDL_OBJS += src/systems/sdl/sdl_text_system.o 
LIBSYSTEM_SDL_OBJS += src/systems/sdl/sdl_text_window.o 
LIBSYSTEM_SDL_OBJS += src/systems/sdl/sdl_utils.o 
LIBSYSTEM_SDL_OBJS += src/systems/sdl/shaders.o 
LIBSYSTEM_SDL_OBJS += src/systems/sdl/texture.o 
LIBSYSTEM_SDL_OBJS += vendor/pygame/alphablit.o

LIBSDL_MIXER_OBJS :=

LIBSDL_MIXER_OBJS += vendor/SDL_mixer/src/dynamic_ogg.o 
LIBSDL_MIXER_OBJS += vendor/SDL_mixer/src/effect_position.o 
LIBSDL_MIXER_OBJS += vendor/SDL_mixer/src/effects_internal.o 
LIBSDL_MIXER_OBJS += vendor/SDL_mixer/src/effect_stereoreverse.o 
LIBSDL_MIXER_OBJS += vendor/SDL_mixer/src/load_aiff.o 
LIBSDL_MIXER_OBJS += vendor/SDL_mixer/src/load_ogg.o 
LIBSDL_MIXER_OBJS += vendor/SDL_mixer/src/load_voc.o 
LIBSDL_MIXER_OBJS += vendor/SDL_mixer/src/mixer.o 
LIBSDL_MIXER_OBJS += vendor/SDL_mixer/src/music.o 
LIBSDL_MIXER_OBJS += vendor/SDL_mixer/src/music_ogg.o 
LIBSDL_MIXER_OBJS += vendor/SDL_mixer/src/wavestream.o

LIBGLEW_OBJS := 

LIBGLEW_OBJS += vendor/GLEW/src/glew.o

#-Wno-deprecated-declarations
#-ftemplate-depth-128 -O3 -finline-functions -Wno-inline -Wall -pthread -DBOOST_ALL_NO_LIB=1 -DBOOST_DATE_TIME_STATIC_LINK -DDATE_TIME_INLINE -DNDEBUG
#-ftemplate-depth-128 -O3 -finline-functions -Wno-inline -Wall -pthread  -DBOOST_ALL_NO_LIB=1 -DBOOST_SYSTEM_STATIC_LINK=1 -DNDEBUG  -I"."
#-ftemplate-depth-128 -O3 -finline-functions -Wno-inline -Wall -pthread  -DBOOST_ALL_NO_LIB=1 -DBOOST_FILESYSTEM_STATIC_LINK=1 -DBOOST_SYSTEM_STATIC_LINK=1 -DNDEBUG  -I"."
#-ftemplate-depth-128 -O3 -finline-functions -Wno-inline -Wall -pthread  -DBOOST_ALL_NO_LIB=1 -DBOOST_IOSTREAMS_USE_DEPRECATED -DNDEBUG  -I"."
#-ftemplate-depth-128 -O3 -finline-functions -Wno-inline -Wall -pthread  -DBOOST_ALL_NO_LIB=1 -DNDEBUG  -I"."
#-ftemplate-depth-128 -O3 -finline-functions -Wno-inline -Wall -pthread  -DBOOST_ALL_NO_LIB=1 -DNDEBUG  -I"."
#-ftemplate-depth-128 -O3 -finline-functions -Wno-inline -Wall -pthread  -DBOOST_ALL_NO_LIB=1 -DNDEBUG  -I"."
#-ftemplate-depth-128 -O3 -finline-functions -Wno-inline -Wall -pedantic -pthread -Wextra -Wno-long-long -Wno-variadic-macros -Wunused-function -pedantic -DBOOST_ALL_NO_LIB=1 -DBOOST_SYSTEM_STATIC_LINK=1 -DBOOST_THREAD_BUILD_LIB=1 -DBOOST_THREAD_DONT_USE_CHRONO -DBOOST_THREAD_POSIX -DNDEBUG  -I"."
LIBBOOST_OBJS := 

LIBBOOST_OBJS += vendor/boost_1_55_0/libs/date_time/src/gregorian/greg_month.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/date_time/src/gregorian/greg_weekday.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/date_time/src/gregorian/date_generators.o

LIBBOOST_OBJS += vendor/boost_1_55_0/libs/system/src/error_code.o

LIBBOOST_OBJS += vendor/boost_1_55_0/libs/filesystem/src/codecvt_error_category.o 
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/filesystem/src/operations.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/filesystem/src/path.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/filesystem/src/path_traits.o 
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/filesystem/src/portability.o 
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/filesystem/src/unique_path.o 
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/filesystem/src/utf8_codecvt_facet.o 
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/filesystem/src/windows_file_codecvt.o

LIBBOOST_OBJS += vendor/boost_1_55_0/libs/iostreams/src/file_descriptor.o 
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/iostreams/src/mapped_file.o 
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/iostreams/src/bzip2.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/iostreams/src/gzip.o 
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/iostreams/src/zlib.o

LIBBOOST_OBJS += vendor/boost_1_55_0/libs/program_options/src/cmdline.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/program_options/src/config_file.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/program_options/src/options_description.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/program_options/src/parsers.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/program_options/src/variables_map.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/program_options/src/value_semantic.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/program_options/src/positional_options.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/program_options/src/utf8_codecvt_facet.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/program_options/src/convert.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/program_options/src/winmain.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/program_options/src/split.o

LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/basic_archive.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/basic_iarchive.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/basic_iserializer.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/basic_oarchive.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/basic_oserializer.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/basic_pointer_iserializer.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/basic_pointer_oserializer.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/basic_serializer_map.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/basic_text_iprimitive.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/basic_text_oprimitive.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/basic_xml_archive.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/binary_iarchive.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/binary_oarchive.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/extended_type_info.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/extended_type_info_typeid.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/extended_type_info_no_rtti.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/polymorphic_iarchive.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/polymorphic_oarchive.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/stl_port.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/text_iarchive.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/text_oarchive.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/void_cast.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/archive_exception.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/xml_grammar.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/xml_iarchive.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/xml_oarchive.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/xml_archive_exception.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/shared_ptr_helper.o

LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/basic_text_wiprimitive.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/basic_text_woprimitive.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/text_wiarchive.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/text_woarchive.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/utf8_codecvt_facet.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/xml_wgrammar.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/xml_wiarchive.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/xml_woarchive.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/serialization/src/codecvt_null.o

LIBBOOST_OBJS += vendor/boost_1_55_0/libs/thread/src/pthread/thread.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/thread/src/pthread/once.o
LIBBOOST_OBJS += vendor/boost_1_55_0/libs/thread/src/future.o

LIBGL4ES_OBJS += vendor/gl4es/src/gl/arbconverter.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/arbgenerator.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/arbhelper.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/arbparser.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/array.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/blend.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/blit.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/buffers.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/build_info.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/debug.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/decompress.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/depth.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/directstate.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/drawing.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/enable.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/envvars.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/eval.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/face.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/fog.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/fpe.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/fpe_cache.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/fpe_shader.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/framebuffers.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/gl_lookup.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/getter.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/gl4es.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/glstate.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/hint.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/init.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/light.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/line.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/list.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/listdraw.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/listrl.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/loader.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/logs.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/matrix.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/matvec.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/oldprogram.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/pixel.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/planes.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/pointsprite.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/preproc.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/program.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/queries.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/raster.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/render.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/samplers.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/shader.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/shaderconv.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/shader_hacks.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/stack.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/stencil.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/string_utils.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/stubs.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/texenv.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/texgen.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/texture.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/texture_compressed.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/texture_params.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/texture_read.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/texture_3d.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/uniform.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/vertexattrib.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/wrap/gl4eswraps.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/wrap/gles.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/wrap/glstub.o
LIBGL4ES_OBJS += vendor/gl4es/src/gl/math/matheval.o
LIBGL4ES_OBJS += vendor/gl4es/src/glx/hardext.o
LIBGL4ES_OBJS += vendor/gl4es/src/glx/glx.o
LIBGL4ES_OBJS += vendor/gl4es/src/glx/lookup.o
LIBGL4ES_OBJS += vendor/gl4es/src/glx/gbm.o
LIBGL4ES_OBJS += vendor/gl4es/src/glx/streaming.o

OBJS := 
OBJS += src/machine/rlvm_instance.o 
OBJS += src/platforms/gtk/rlvm.o 
OBJS += src/platforms/gtk/gtk_rlvm_instance.o 

LIBS := 
LIBS += libguichan_platform.a 
LIBS += libsystem_sdl.a 
LIBS += librlvm.a 
LIBS += libguichan.a 
#LIBS += libSDL_mixer.a 
LIBS += libGLEW.a 
LIBS += libboost.a 
LIBS += libgl4es.a 

all: rlvm

rlvm: $(LIBS) $(OBJS)
	$(CPP) $(CCFLAGS) -o $@ $(OBJS) $(LIBS) $(LDFLAGS)

libguichan_platform.a: $(LIBGUICHAN_PLATFORM_OBJS)
	$(AR) $@ $(LIBGUICHAN_PLATFORM_OBJS)
	$(RANLIB) $@		

libsystem_sdl.a: $(LIBSYSTEM_SDL_OBJS)
	$(AR) $@ $(LIBSYSTEM_SDL_OBJS)
	$(RANLIB) $@	

librlvm.a: $(LIBRLVM_OBJS)
	$(AR) $@ $(LIBRLVM_OBJS)
	$(RANLIB) $@	
	
libguichan.a: $(LIBGUICHAN_OBJS)
	$(AR) $@ $(LIBGUICHAN_OBJS)
	$(RANLIB) $@	
	
libSDL_mixer.a: $(LIBSDL_MIXER_OBJS)
	$(AR) $@ $(LIBSDL_MIXER_OBJS)
	$(RANLIB) $@	
	
libGLEW.a: $(LIBGLEW_OBJS)
	$(AR) $@ $(LIBGLEW_OBJS)
	$(RANLIB) $@

libboost.a: $(LIBBOOST_OBJS)
	$(AR) $@ $(LIBBOOST_OBJS)
	$(RANLIB) $@	

libgl4es.a: $(LIBGL4ES_OBJS)
	$(AR) $@ $(LIBGL4ES_OBJS)
	$(RANLIB) $@	

%.o : %.S
	$(CC) $(CCFLAGS) -o $@ -c $<	
	
%.o : %.c
	$(CC) -c $(CCFLAGS) -o $@ -c $<

%.o : %.cpp
	$(CPP) $(CCFLAGS) -o $@ -c $<

%.o : %.cc
	$(CPP) $(CCFLAGS) -o $@ -c $<

clean: 
	$(RM) rlvm $(LIBS) $(OBJS)
	$(RM) $(LIBGUICHAN_PLATFORM_OBJS)
	$(RM) $(LIBSYSTEM_SDL_OBJS)
	$(RM) $(LIBRLVM_OBJS)
	$(RM) $(LIBGUICHAN_OBJS)
	$(RM) $(LIBSDL_MIXER_OBJS)
	$(RM) $(LIBGLEW_OBJS)
	$(RM) $(LIBBOOST_OBJS)
	$(RM) $(LIBGL4ES_OBJS)

test:
	./rlvm

debug:
	gdb ./rlvm

