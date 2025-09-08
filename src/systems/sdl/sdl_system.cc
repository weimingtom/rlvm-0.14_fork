// -*- Mode: C++; tab-width:2; indent-tabs-mode: nil; c-basic-offset: 2 -*-
// vi:tw=80:et:ts=2:sts=2
//
// -----------------------------------------------------------------------
//
// This file is part of RLVM, a RealLive virtual machine clone.
//
// -----------------------------------------------------------------------
//
// Copyright (C) 2006, 2007 Elliot Glaysher
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
//
// -----------------------------------------------------------------------

#include "systems/sdl/sdl_system.h"

#if USE_SDL2
#include <SDL2/SDL.h>
#else
#include <SDL/SDL.h>
#endif

#include <sstream>

#include "libreallive/defs.h"
#include "libreallive/gameexe.h"
#include "machine/rlmachine.h"
#include "systems/base/graphics_object.h"
#include "systems/base/graphics_object_data.h"
#include "systems/base/platform.h"
#include "systems/sdl/sdl_event_system.h"
#include "systems/sdl/sdl_graphics_system.h"
#include "systems/sdl/sdl_sound_system.h"
#include "systems/sdl/sdl_text_system.h"

// -----------------------------------------------------------------------

SDLSystem::SDLSystem(Gameexe& gameexe) : System(), gameexe_(gameexe) {
  // First, initialize SDL's video subsystem.
  if (SDL_Init(SDL_INIT_VIDEO) < 0) {
    std::ostringstream ss;
    ss << "Video initialization failed: " << SDL_GetError();
    throw libreallive::Error(ss.str());
  }

#if USE_SDL2 && defined(MIYOO)	
    if(SDL_InitSubSystem( SDL_INIT_JOYSTICK ) == 0 && SDL_JoystickOpen(0) != NULL) {
		SDL_LogError(SDL_LOG_CATEGORY_APPLICATION, "Initialize JOYSTICK: %s\n", SDL_GetError());		
    }
	
//copy from https://github.com/weimingtom/kirikiroid2-miyoo-a30/blob/master/cocos/platform/desktop/CCGLViewImpl-desktop.cpp
//some code is in ONScripter_event.cpp
	if (SDL_InitSubSystem/*SDL_Init*/(/*SDL_INIT_AUDIO|SDL_INIT_EVENTS | SDL_INIT_JOYSTICK | */SDL_INIT_GAMECONTROLLER ) < 0) {
        SDL_LogError(SDL_LOG_CATEGORY_APPLICATION, "Couldn't initialize SDL: %s\n", SDL_GetError());
	} else {
		
		//------testgamecontroller.c
		int i;
		int nController = 0;
		int retcode = 0;
		char guid[64];
		SDL_GameController *gamecontroller;
		/* Print information about the controller */
		for (i = 0; i < SDL_NumJoysticks(); ++i) {
			const char *name;
			const char *description;

			SDL_JoystickGetGUIDString(SDL_JoystickGetDeviceGUID(i),
									  guid, sizeof (guid));

			if ( SDL_IsGameController(i) )
			{
				nController++;
				name = SDL_GameControllerNameForIndex(i);
				description = "Controller";
			} else {
				name = SDL_JoystickNameForIndex(i);
				description = "Joystick";
			}
			SDL_Log("%s %d: %s (guid %s, VID 0x%.4x, PID 0x%.4x)\n",
				description, i, name ? name : "Unknown", guid,
				SDL_JoystickGetDeviceVendor(i), SDL_JoystickGetDeviceProduct(i));
		}
		SDL_Log("There are %d game controller(s) attached (%d joystick(s))\n", nController, SDL_NumJoysticks());


		char *argv1 = "0";
		if (argv1) {
			SDL_bool reportederror = SDL_FALSE;
			SDL_bool keepGoing = SDL_TRUE;
			SDL_Event event;
			int device = atoi(argv1);
			if (device >= SDL_NumJoysticks()) {
				SDL_LogError(SDL_LOG_CATEGORY_APPLICATION, "%i is an invalid joystick index.\n", device);
				retcode = 1;
			} else {
				SDL_JoystickGetGUIDString(SDL_JoystickGetDeviceGUID(device),
										  guid, sizeof (guid));
				SDL_Log("Attempting to open device %i, guid %s\n", device, guid);
				gamecontroller = SDL_GameControllerOpen(device);

				if (gamecontroller != NULL) {
					SDL_assert(SDL_GameControllerFromInstanceID(SDL_JoystickInstanceID(SDL_GameControllerGetJoystick(gamecontroller))) == gamecontroller);
				}

			}
		}

		//getchar();
	}


//------testgamecontroller.c
#endif //defined(MIYOO)  
  
  
  // Initialize the various subsystems
  graphics_system_.reset(new SDLGraphicsSystem(*this, gameexe));
  event_system_.reset(new SDLEventSystem(*this, gameexe));
  text_system_.reset(new SDLTextSystem(*this, gameexe));
  sound_system_.reset(new SDLSoundSystem(*this));

  event_system_->AddMouseListener(graphics_system_.get());
  event_system_->AddMouseListener(text_system_.get());
}

// -----------------------------------------------------------------------

SDLSystem::~SDLSystem() {
  event_system_->RemoveMouseListener(text_system_.get());
  event_system_->RemoveMouseListener(graphics_system_.get());

  // Some combinations of SDL and FT on the Mac require us to destroy the
  // Platform first. This will crash on Tiger if this isn't here, but it won't
  // crash under Linux...
  platform_.reset();

  // Force the deletion of the various systems before we shut down
  // SDL.
  sound_system_.reset();
  graphics_system_.reset();
  event_system_.reset();
  text_system_.reset();

  SDL_Quit();
}

// -----------------------------------------------------------------------
#if MY_USE_GLES2
extern bool global_texture_reload;
#endif

void SDLSystem::Run(RLMachine& machine) {
  // Give the event handler a chance to run.
  event_system_->ExecuteEventSystem(machine);
  text_system_->ExecuteTextSystem();
  sound_system_->ExecuteSoundSystem();
#if MY_USE_GLES2
  if (!global_texture_reload)
    graphics_system_->ExecuteGraphicsSystem(machine);
#else 
  graphics_system_->ExecuteGraphicsSystem(machine);
#endif

  if (platform())
    platform()->Run(machine);
}

// -----------------------------------------------------------------------

GraphicsSystem& SDLSystem::graphics() { return *graphics_system_; }

// -----------------------------------------------------------------------

EventSystem& SDLSystem::event() { return *event_system_; }

// -----------------------------------------------------------------------

Gameexe& SDLSystem::gameexe() { return gameexe_; }

// -----------------------------------------------------------------------

SDLTextSystem& SDLSystem::text() { return *text_system_; }

// -----------------------------------------------------------------------

SoundSystem& SDLSystem::sound() { return *sound_system_; }

SDLGraphicsSystem* getSDLGraphics(System& system) {
  return static_cast<SDLGraphicsSystem*>(&system.graphics());
}
