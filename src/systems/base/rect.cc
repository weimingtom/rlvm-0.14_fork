// -*- Mode: C++; tab-width:2; indent-tabs-mode: nil; c-basic-offset: 2 -*-
// vi:tw=80:et:ts=2:sts=2
//
// -----------------------------------------------------------------------
//
// This file is part of RLVM, a RealLive virtual machine clone.
//
// -----------------------------------------------------------------------
//
// Copyright (C) 2008 Elliot Glaysher
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

#include "systems/base/rect.h"

#include <algorithm>
#include <ostream>

// -----------------------------------------------------------------------
// Point
// -----------------------------------------------------------------------
std::ostream& operator<<(std::ostream& os, const Point& p) {
  os << "Point(" << p.x() << ", " << p.y() << ")";
  return os;
}

// -----------------------------------------------------------------------
// Size
// -----------------------------------------------------------------------
Rect Size::CenteredIn(const Rect& r) const {
  int half_r_width = r.width() / 2;
  int half_r_height = r.height() / 2;

  int half_width = width() / 2;
  int half_height = height() / 2;

  int new_x = r.x() + half_r_width - half_width;
  int new_y = r.y() + half_r_height - half_height;

  return Rect(Point(new_x, new_y), *this);
}

Size Size::SizeUnion(const Size& rhs) const {
  return Size(std::max(width_, rhs.width_), std::max(height_, rhs.height_));
}

std::ostream& operator<<(std::ostream& os, const Size& s) {
  os << "Size(" << s.width() << ", " << s.height() << ")";
  return os;
}

// -----------------------------------------------------------------------
// Rect
// -----------------------------------------------------------------------
bool Rect::Contains(const Point& loc) {
  return loc.x() >= x() && loc.x() < x2() && loc.y() >= y() && loc.y() < y2();
}

bool Rect::Intersects(const Rect& rhs) const {
  return !(x() > rhs.x2() || x2() < rhs.x() || y() > rhs.y2() ||
           y2() < rhs.y());
}

Rect Rect::Intersection(const Rect& rhs) const {
  if (Intersects(rhs)) {
    return Rect::GRP(std::max(x(), rhs.x()),
                     std::max(y(), rhs.y()),
                     std::min(x2(), rhs.x2()),
                     std::min(y2(), rhs.y2()));
  }

  return Rect();
}

Rect Rect::RectUnion(const Rect& rhs) const {
  if (is_empty()) {
    return rhs;
  } else if (rhs.is_empty()) {
    return *this;
  } else {
    return Rect::GRP(std::min(x(), rhs.x()),
                     std::min(y(), rhs.y()),
                     std::max(x2(), rhs.x2()),
                     std::max(y2(), rhs.y2()));
  }
}

Rect Rect::GetInsetRectangle(const Rect& rhs) const {
  Size p = rhs.origin() - origin();
  return Rect(Point(p.width(), p.height()), rhs.size());
}

Rect Rect::ApplyInset(const Rect& inset) const {
  Point p = origin() + inset.origin();
  return Rect(p, inset.size());
}

std::ostream& operator<<(std::ostream& os, const Rect& r) {
  os << "Rect(" << r.x() << ", " << r.y() << ", " << r.size() << ")";
  return os;
}







void getScreenRect(Size& sz)
{
	sz = Size(1280, 720); //For Trimui Smart Pro
}

void getViewRect(Size& sz)
{
#if 0
  std::vector<int> graphicsMode = gameexe("SCREENSIZE_MOD");
  if (graphicsMode.size()) {
    if (graphicsMode[0] == 0) {
      sz = Size(640, 480);
    } else if (graphicsMode[0] == 1) {
      sz = Size(800, 600);
    } else if (graphicsMode[0] == 999 && graphicsMode.size() >= 3) {
      sz = Size(graphicsMode[1], graphicsMode[2]);
    } else {
	  sz = Size(1280, 720);
    }
  } else {
	sz = Size(1280, 720);
  }
#else  
  sz = Size(800, 600); 
#endif 
}

void calcScreenRect(const Rect &srcRect, Rect &dstRect)
{
Size screen_size;	
Size view_size;	
getScreenRect(screen_size);	
getViewRect(view_size);	
	
#if 0
//(1280 - 800) / 2, (720 - 600) / 2 
	dstRect = srcRect;	
	dstRect.set_x(dstRect.x() + (screen_size.width() - view_size.width()) / 2);
	dstRect.set_y(dstRect.y() + (screen_size.height() - view_size.height()) / 2);
	dstRect.set_x2((int)(dstRect.x() + dstRect.width() * 1.0));
	dstRect.set_y2((int)(dstRect.y() + dstRect.height() * 1.0));	
#else
    dstRect = srcRect;
    double scale = (double)screen_size.height() / (double) view_size.height();
	dstRect.set_x(dstRect.x() * scale + (int)(((double)screen_size.width() - view_size.width() * scale) / 2));
	dstRect.set_y(dstRect.y() * scale + 0);	
	dstRect.set_x2((int)((double)dstRect.x() + dstRect.width() * scale));
	dstRect.set_y2((int)((double)dstRect.y() + dstRect.height() * scale));	
#endif
}

void calcScreenRect(int& fdx1, int& fdy1, int& fdx2, int& fdy2)
{
	Point p1(fdx1, fdy1);
	Point p2(fdx2, fdy2);	
	Rect srcRect(p1, p2);
	Rect dstRect;
	calcScreenRect(srcRect, dstRect);
	fdx1 = dstRect.x();
	fdy1 = dstRect.y();
	fdx2 = dstRect.x2();
	fdy2 = dstRect.y2();
}

void calcMouseXY(int32_t& fdx1, int32_t& fdy1)
{
#if 0
	Point p1(0, 0);
	Point p2(fdx1, fdy1);	
	Rect srcRect(p1, p2);
	Rect dstRect;
	calcScreenRect(srcRect, dstRect);
	fdx1 += dstRect.width();
	fdy1 += dstRect.height();
#else
//  fdx1 = (int)((double)fdx1 * ((double)720 / (double)600));
//  fdy1 = (int)((double)fdy1 * ((double)720 / (double)600));
  
#endif
}

int g_change_mouse_pos = 1;


