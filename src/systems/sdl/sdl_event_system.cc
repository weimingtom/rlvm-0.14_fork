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

#include "systems/sdl/sdl_event_system.h"

#if USE_SDL2
#include <SDL2/SDL.h>
#else
#include <SDL/SDL.h>
#endif

#include <functional>

#include "machine/rlmachine.h"
#include "systems/base/event_listener.h"
#include "systems/base/graphics_system.h"
#include "systems/sdl/sdl_system.h"

#if MY_USE_GLES2
//#include "log.h"

extern bool global_texture_reload;
#endif

using std::bind;
using std::placeholders::_1;

static int c2mx = 0;
static int c2my = 0;
static int is_a_down = 0;
static int is_b_down = 0;
static int is_x_down = 0;
static int is_y_down = 0;
static int is_shoulder_down = 0;

SDLEventSystem::SDLEventSystem(SDLSystem& sys, Gameexe& gexe)
    : EventSystem(gexe),
      shift_pressed_(false),
      ctrl_pressed_(false),
      mouse_inside_window_(true),
      mouse_pos_(),
      button1_state_(0),
      button2_state_(0),
      last_get_currsor_time_(0),
      last_mouse_move_time_(0),
      system_(sys),
      raw_handler_(NULL) {}

void SDLEventSystem::ExecuteEventSystem(RLMachine& machine) {
  SDL_Event event;
  while (SDL_PollEvent(&event)) {
    switch (event.type) {
      case SDL_KEYDOWN: {
//fprintf(stderr, "SDL_KEYDOWN\n");
        if (raw_handler_)
          raw_handler_->pushInput(event);
        else
          HandleKeyDown(machine, event);
        break;
      }
      case SDL_KEYUP: {
        if (raw_handler_)
          raw_handler_->pushInput(event);
        else
          HandleKeyUp(machine, event);
        break;
      }
      case SDL_MOUSEMOTION: {
        if (raw_handler_) {
//calcMouseXY(event.button.x, event.button.y);
g_change_mouse_pos = 0;
          raw_handler_->pushInput(event);
        } else {
g_change_mouse_pos = 1;        
        }
        HandleMouseMotion(machine, event);
        break;
      }
      case SDL_MOUSEBUTTONDOWN:
      case SDL_MOUSEBUTTONUP: {
        if (raw_handler_) {
//calcMouseXY(event.button.x, event.button.y);
fprintf(stderr, "raw_handler_ got mouse event %d, %d\n", event.button.x, event.button.y);
          raw_handler_->pushInput(event);
        } else {
#if MY_USE_GLES2
		  //LOGD("got mouse event\n");
		  fprintf(stderr, "got mouse event\n");
#endif          
		  HandleMouseButtonEvent(machine, event);
        }
		break;
      }
#if USE_SDL2
      case SDL_MOUSEWHEEL:
        HandleWheelEvent(machine, event);
        break;








		
		
		
		

#if defined(MIYOO)
//copy from https://github.com/weimingtom/kirikiroid2-miyoo-a30/blob/master/cocos/platform/desktop/CCGLViewImpl-desktop.cpp
//some init code is in ONScripter.cpp
	case SDL_CONTROLLERBUTTONDOWN:
	case SDL_CONTROLLERBUTTONUP: {

#define JOYSTICK_BUTTON_DPAD_DOWN__ 6
#define JOYSTICK_BUTTON_DPAD_LEFT__ 7
#define JOYSTICK_BUTTON_DPAD_UP__ 8 
#define JOYSTICK_BUTTON_DPAD_RIGHT__ 9
int c2jbutton = -1;
int c2kbutton = -1;


#if 1//defined(USE_DEBUG_INPUT)
SDL_Log("%s, %s, %d\n", 
(event.type == SDL_CONTROLLERBUTTONDOWN) ? 
"SDL_CONTROLLERBUTTONDOWN" : 
"SDL_CONTROLLERBUTTONUP", 
(event.cbutton.state == SDL_PRESSED) ? 
"SDL_PRESSED" : 
"SDL_RELEASED", 
event.cbutton.button);
#endif				
		switch (event.cbutton.state) {
			case SDL_PRESSED:

//trimui smart pro:
//UP:11
//DOWN:12
//LEFT:13
//RIGHT:14
//A:1(joy 1, only up)
//B:0(joy 0)
//X:3(joy 3)
//Y:2(joy 2)
//L1:9(Joy 4)
//L2:10(Joy 5)
//Start:6(Joy 7)
//Select:4(Joy 6)
//Menu:5(Joy 8)
//joy: joyaxismotion
//key: Power(102, VolumeUp(128), VolumeDown(129)
//===
//plan:
//A=return=kag3.Return
//B=space=kag3.Space
//X=fast=kag3.F(#'F')
//Y=menu=kag3.ESC=message history
//
//Select=????
//Start=auto=kag3.A
//Menu=exit=???kage3.exit
//
//L1=left?=?kag3.B=back?
//R1=right?
//
//?=kage3.S=save?
//?=kage3.L=load?
if (event.cbutton.button == SDL_CONTROLLER_BUTTON_START)
{
machine.Halt();
//event.cbutton.button == SDL_CONTROLLER_BUTTON_BACK ||
//event.cbutton.button == SDL_CONTROLLER_BUTTON_GUIDE ||
//event.cbutton.button == SDL_CONTROLLER_BUTTON_LEFTSHOULDER ||
//event.cbutton.button == SDL_CONTROLLER_BUTTON_RIGHTSHOULDER
}
if (event.cbutton.button == SDL_CONTROLLER_BUTTON_BACK)//select
{
  c2mx = c2my = 0;
SDL_Event mevent = {0};
mevent.type = SDL_MOUSEMOTION;
mevent.motion.x = c2mx;
mevent.motion.y = c2my;
SDL_PushEvent(&mevent);  
}
if (event.cbutton.button == SDL_CONTROLLER_BUTTON_LEFTSHOULDER ||
event.cbutton.button == SDL_CONTROLLER_BUTTON_RIGHTSHOULDER)
{
is_shoulder_down = 1;
}
if (event.cbutton.button == SDL_CONTROLLER_BUTTON_A)
{
  is_a_down = 1;
//InjectMouseDown(machine);  
SDL_Event mevent = {0};
mevent.type = SDL_MOUSEBUTTONDOWN;
mevent.button.button = SDL_BUTTON_LEFT;
SDL_PushEvent(&mevent);
}
if (event.cbutton.button == SDL_CONTROLLER_BUTTON_B)
{
  is_b_down = 1;
//InjectMouseDown(machine);
SDL_Event mevent = {0};
mevent.type = SDL_MOUSEBUTTONDOWN;
mevent.button.button = SDL_BUTTON_LEFT;
SDL_PushEvent(&mevent);
}
if (event.cbutton.button == SDL_CONTROLLER_BUTTON_X)
{
  is_x_down = 1;
}
if (event.cbutton.button == SDL_CONTROLLER_BUTTON_Y)
{
  is_y_down = 1;

#if 1
SDL_Event mevent = {0};
mevent.type = SDL_MOUSEBUTTONDOWN;
mevent.button.button = SDL_BUTTON_RIGHT;
SDL_PushEvent(&mevent);
#else
machine.system().graphics().ToggleFullscreen();
#endif
}
if (event.cbutton.button == SDL_CONTROLLER_BUTTON_DPAD_UP)
{
        c2jbutton = JOYSTICK_BUTTON_DPAD_UP__;
	c2kbutton = SDLK_UP;
printf("emulate SDLK_UP\n");
}
if (event.cbutton.button == SDL_CONTROLLER_BUTTON_DPAD_DOWN)
{
        c2jbutton = JOYSTICK_BUTTON_DPAD_DOWN__;
	c2kbutton = SDLK_DOWN;
printf("emulate SDLK_DOWN\n");
}
if (event.cbutton.button == SDL_CONTROLLER_BUTTON_DPAD_LEFT)
{
        c2jbutton = JOYSTICK_BUTTON_DPAD_LEFT__;
	c2kbutton = SDLK_LEFT;
printf("emulate SDLK_LEFT\n");
}
if (event.cbutton.button == SDL_CONTROLLER_BUTTON_DPAD_RIGHT)
{
        c2jbutton = JOYSTICK_BUTTON_DPAD_RIGHT__;
	c2kbutton = SDLK_RIGHT;
printf("emulate SDLK_RIGHT\n");
}
if (c2kbutton >=0) //c2jbutton >= 0)
{
//SDL_Event mevent = {0};
//mevent.type = SDL_MOUSEMOTION;
//mevent.motion.x = screen_device_width / 2;
//mevent.motion.y = screen_device_height / 2;
//SDL_PushEvent(&mevent);
//SDL_WarpMouseInWindow(window, screen_device_width / 2, screen_device_height / 2);

//SDL_Event ev2 = {0};
//ev2.type = SDL_KEYDOWN;
//ev2.key.state = SDL_PRESSED;
//ev2.key.keysym.scancode = (SDL_Scancode)c2kbutton;
//ev2.key.keysym.sym = (SDL_Scancode)c2kbutton;
//SDL_PushEvent(&ev2);
}
				break;
				
			case SDL_RELEASED:
if (event.cbutton.button == SDL_CONTROLLER_BUTTON_LEFTSHOULDER ||
event.cbutton.button == SDL_CONTROLLER_BUTTON_RIGHTSHOULDER)
{
is_shoulder_down = 0;
}			
if (event.cbutton.button == SDL_CONTROLLER_BUTTON_A)
{
  is_a_down = 0;
//InjectMouseUp(machine);  
SDL_Event mevent = {0};
mevent.type = SDL_MOUSEBUTTONUP;
mevent.button.button = SDL_BUTTON_LEFT;
SDL_PushEvent(&mevent);
}
if (event.cbutton.button == SDL_CONTROLLER_BUTTON_B)
{
  is_b_down = 0;
//InjectMouseUp(machine); 
SDL_Event mevent = {0};
mevent.type = SDL_MOUSEBUTTONUP;
mevent.button.button = SDL_BUTTON_LEFT;
SDL_PushEvent(&mevent);
}
if (event.cbutton.button == SDL_CONTROLLER_BUTTON_X)
{
  is_x_down = 0;
}
if (event.cbutton.button == SDL_CONTROLLER_BUTTON_Y)
{
  is_y_down = 0;
SDL_Event mevent = {0};
mevent.type = SDL_MOUSEBUTTONUP;
mevent.button.button = SDL_BUTTON_RIGHT;
SDL_PushEvent(&mevent);
}			
if (event.cbutton.button == SDL_CONTROLLER_BUTTON_DPAD_UP)
{
        c2jbutton = JOYSTICK_BUTTON_DPAD_UP__;
	c2kbutton = SDLK_UP;
printf("emulate SDLK_UP\n");
  c2mx += 0;
  if (is_x_down || is_shoulder_down) {
    c2my += -50;
  } else {
    c2my += -5;
  }
}
if (event.cbutton.button == SDL_CONTROLLER_BUTTON_DPAD_DOWN)
{
        c2jbutton = JOYSTICK_BUTTON_DPAD_DOWN__;
	c2kbutton = SDLK_DOWN;
printf("emulate SDLK_DOWN\n");
  c2mx += 0;
  if (is_x_down || is_shoulder_down) {
    c2my += 50;
  } else {
    c2my += 5;
  }
  
}
if (event.cbutton.button == SDL_CONTROLLER_BUTTON_DPAD_LEFT)
{
        c2jbutton = JOYSTICK_BUTTON_DPAD_LEFT__;
	c2kbutton = SDLK_LEFT;
printf("emulate SDLK_LEFT\n");
  if (is_x_down || is_shoulder_down) {
    c2mx += -50;
  } else {
    c2mx += -5;
  }
  c2my += 0;
}
if (event.cbutton.button == SDL_CONTROLLER_BUTTON_DPAD_RIGHT)
{
        c2jbutton = JOYSTICK_BUTTON_DPAD_RIGHT__;
	c2kbutton = SDLK_RIGHT;
printf("emulate SDLK_RIGHT\n");
  if (is_x_down || is_shoulder_down) {
    c2mx += 50;
  } else {
    c2mx += 5;
  }
  c2my += 0;
}
if (c2kbutton >=0) //c2jbutton >= 0)
{
SDL_Event mevent = {0};
mevent.type = SDL_MOUSEMOTION;
mevent.motion.x = c2mx;
mevent.motion.y = c2my;
SDL_PushEvent(&mevent);
//SDL_WarpMouseInWindow(window, screen_device_width / 2, screen_device_height / 2);

//SDL_Event ev2 = {0};
//ev2.type = SDL_KEYUP;
//ev2.key.state = SDL_RELEASED;
//ev2.key.keysym.scancode = (SDL_Scancode)c2kbutton;
//ev2.key.keysym.sym = (SDL_Scancode)c2kbutton;
//SDL_PushEvent(&ev2);
}
				break;
		}
	}
	break;
#endif //defined(MIYOO)	



















		
#endif
      case SDL_QUIT:
        machine.Halt();
        break;
#if USE_SDL2		
	  case SDL_WINDOWEVENT:
        if (raw_handler_)
          raw_handler_->pushInput(event);
        HandleWindowEvent(machine, event);
        break;	
#else
      case SDL_ACTIVEEVENT:
        if (raw_handler_)
          raw_handler_->pushInput(event);
        HandleActiveEvent(machine, event);
        break;
      case SDL_VIDEOEXPOSE: {
        machine.system().graphics().ForceRefresh();
        break;
      }
#endif
    }
  }
}

bool SDLEventSystem::CtrlPressed() const {
  return system_.force_fast_forward() || ctrl_pressed_;
}

Point SDLEventSystem::GetCursorPos() {
  PreventCursorPosSpinning();
  return mouse_pos_;
}

void SDLEventSystem::GetCursorPos(Point& position, int& button1, int& button2) {
  PreventCursorPosSpinning();
  position = mouse_pos_;
  button1 = button1_state_;
  button2 = button2_state_;
}

void SDLEventSystem::FlushMouseClicks() {
  button1_state_ = 0;
  button2_state_ = 0;
}

unsigned int SDLEventSystem::TimeOfLastMouseMove() {
  return last_mouse_move_time_;
}

unsigned int SDLEventSystem::GetTicks() const { return SDL_GetTicks(); }

void SDLEventSystem::Wait(unsigned int milliseconds) const {
  SDL_Delay(milliseconds);
}

bool SDLEventSystem::ShiftPressed() const { return shift_pressed_; }

void SDLEventSystem::InjectMouseMovement(RLMachine& machine, const Point& loc) {
  mouse_pos_ = loc;
  BroadcastEvent(machine, bind(&EventListener::MouseMotion, _1, mouse_pos_));
}

void SDLEventSystem::InjectMouseDown(RLMachine& machine) {
  button1_state_ = 1;
  button2_state_ = 0;

  DispatchEvent(
      machine,
      bind(&EventListener::MouseButtonStateChanged, _1, MOUSE_LEFT, 1));
}

void SDLEventSystem::InjectMouseUp(RLMachine& machine) {
  button1_state_ = 2;
  button2_state_ = 0;

  DispatchEvent(
      machine,
      bind(&EventListener::MouseButtonStateChanged, _1, MOUSE_LEFT, 1));
}

void SDLEventSystem::PreventCursorPosSpinning() {
  unsigned int newTime = GetTicks();

  if ((system_.graphics().screen_update_mode() !=
       GraphicsSystem::SCREENUPDATEMODE_MANUAL) &&
      (newTime - last_get_currsor_time_) < 20) {
    // Prevent spinning on input. When we're not in manual mode, we don't get
    // convenient refresh() calls to insert pauses at. Instead, we need to sort
    // of intuit about what's going on and the easiest way to slow down is to
    // track when the bytecode keeps spamming us for the cursor.
    system_.set_force_wait(true);
  }

  last_get_currsor_time_ = newTime;
}

void SDLEventSystem::HandleKeyDown(RLMachine& machine, SDL_Event& event) {
  switch (event.key.keysym.sym) {
    case SDLK_LSHIFT:
    case SDLK_RSHIFT: {
      shift_pressed_ = true;
      break;
    }
    case SDLK_LCTRL:
    case SDLK_RCTRL: {
      ctrl_pressed_ = true;
      break;
    }
    case SDLK_RETURN:
    case SDLK_f: {
      if ((event.key.keysym.mod & KMOD_ALT) ||
#if USE_SDL2
          (event.key.keysym.mod & KMOD_GUI)) {
#else
          (event.key.keysym.mod & KMOD_META)) {
#endif
        machine.system().graphics().ToggleFullscreen();

        // Stop processing because we don't want to Dispatch this event, which
        // might advance the text.
        return;
      }

      break;
    }
    default:
      break;
  }

  KeyCode code = KeyCode(event.key.keysym.sym);
  DispatchEvent(machine, bind(&EventListener::KeyStateChanged, _1, code, true));
}

void SDLEventSystem::HandleKeyUp(RLMachine& machine, SDL_Event& event) {
  switch (event.key.keysym.sym) {
    case SDLK_LSHIFT:
    case SDLK_RSHIFT: {
      shift_pressed_ = false;
      break;
    }
    case SDLK_LCTRL:
    case SDLK_RCTRL: {
      ctrl_pressed_ = false;
      break;
    }
    case SDLK_F1: {
      machine.system().ShowSystemInfo(machine);
      break;
    }
    case SDLK_F12: {
      machine.system().DumpRenderTree(machine);
      break;
    }
    default:
      break;
  }

  KeyCode code = KeyCode(event.key.keysym.sym);
  DispatchEvent(machine,
                bind(&EventListener::KeyStateChanged, _1, code, false));
}

void SDLEventSystem::HandleMouseMotion(RLMachine& machine, SDL_Event& event) {
  if (mouse_inside_window_) {
//calcScreenRect
//see MouseCursor::RenderHotspotAt	  
    mouse_pos_ = Point(event.motion.x, event.motion.y);
    last_mouse_move_time_ = GetTicks();

    // Handle this somehow.
    BroadcastEvent(machine, bind(&EventListener::MouseMotion, _1, mouse_pos_));
  }
}

void SDLEventSystem::HandleMouseButtonEvent(RLMachine& machine,
                                            SDL_Event& event) {
  if (mouse_inside_window_) {
    bool pressed = event.type == SDL_MOUSEBUTTONDOWN;
    int press_code = pressed ? 1 : 2;

    if (event.button.button == SDL_BUTTON_LEFT)
      button1_state_ = press_code;
    else if (event.button.button == SDL_BUTTON_RIGHT)
      button2_state_ = press_code;

    MouseButton button = MOUSE_NONE;
    switch (event.button.button) {
      case SDL_BUTTON_LEFT:
        button = MOUSE_LEFT;
        break;
      case SDL_BUTTON_RIGHT:
        button = MOUSE_RIGHT;
        break;
      case SDL_BUTTON_MIDDLE:
        button = MOUSE_MIDDLE;
        break;
		
#if USE_SDL2

#else		
      case SDL_BUTTON_WHEELUP:
        button = MOUSE_WHEELUP;
        break;
      case SDL_BUTTON_WHEELDOWN:
        button = MOUSE_WHEELDOWN;
        break;
#endif

      default:
        break;
    }

    DispatchEvent(
        machine,
        bind(&EventListener::MouseButtonStateChanged, _1, button, pressed));
  }
}

#if USE_SDL2

void SDLEventSystem::HandleWheelEvent(RLMachine& machine, SDL_Event& event) {
  if (mouse_inside_window_) {
    MouseWheelType wheel_event = MOUSE_WHEEL_NONE;
    if (event.wheel.y > 0)
      wheel_event = MOUSE_WHEEL_UP;
    else if (event.wheel.y < 0)
      wheel_event = MOUSE_WHEEL_DOWN;

    if (wheel_event != MOUSE_WHEEL_NONE) {
      DispatchEvent(
          machine,
          bind(&EventListener::MouseWheelEvent, _1, wheel_event));
    }
  }
}

void SDLEventSystem::HandleWindowEvent(RLMachine& machine, SDL_Event& event) {
  if (event.window.event == SDL_WINDOWEVENT_ENTER) {
    // Assume the mouse is inside the window. Actually checking the mouse
    // state doesn't work in the case where we mouse click on another window
    // that's partially covered by rlvm's window and then alt-tab back.
    mouse_inside_window_ = true;

    machine.system().graphics().MarkScreenAsDirty(GUT_MOUSE_MOTION);
  } else if (event.window.event == SDL_WINDOWEVENT_LEAVE) {
    mouse_inside_window_ = false;

    // Force a mouse refresh:
    machine.system().graphics().MarkScreenAsDirty(GUT_MOUSE_MOTION);
  } else if (event.window.event == SDL_WINDOWEVENT_EXPOSED) {
    machine.system().graphics().ForceRefresh();
  }
}

#else

void SDLEventSystem::HandleActiveEvent(RLMachine& machine, SDL_Event& event) {
  if (event.active.state & SDL_APPINPUTFOCUS) {
    // Assume the mouse is inside the window. Actually checking the mouse
    // state doesn't work in the case where we mouse click on another window
    // that's partially covered by rlvm's window and then alt-tab back.
    mouse_inside_window_ = true;

    machine.system().graphics().MarkScreenAsDirty(GUT_MOUSE_MOTION);
  } else if (event.active.state & SDL_APPMOUSEFOCUS) {
    mouse_inside_window_ = event.active.gain == 1;

    // Force a mouse refresh:
    machine.system().graphics().MarkScreenAsDirty(GUT_MOUSE_MOTION);
  }
}

#endif
