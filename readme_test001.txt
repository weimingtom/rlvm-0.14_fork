<<<<<<<<<<<RenderToScreenAsObject src/systems/base/graphics_object_data.cc, 156, alpha == 255, dstRect(0,0,800,600)
<<<<<<<<<<<RenderToScreenAsObject src/systems/base/graphics_object_data.cc, 156, alpha == 255, dstRect(0,0,800,600)
<<<<<<<<<<<RenderToScreenAsObject src/systems/base/graphics_object_data.cc, 156, alpha == 255, dstRect(0,0,800,600)
<<<<<<<<<<<RenderToScreenAsObject src/systems/base/graphics_object_data.cc, 156, alpha == 255, dstRect(0,0,800,600)
<<<<<<<<<<<RenderToScreenAsObject src/systems/base/graphics_object_data.cc, 156, alpha == 255, dstRect(0,0,800,600)
<<<<<<<<<<<RenderToScreenAsObject src/systems/base/graphics_object_data.cc, 156, alpha == 255, dstRect(0,0,800,600)
<<<<<<<<<<<RenderToScreenAsObject src/systems/base/graphics_object_data.cc, 156, alpha == 255, dstRect(0,0,800,600)
<<<<<<<<<<<RenderToScreenAsObject src/systems/base/graphics_object_data.cc, 156, alpha == 255, dstRect(0,0,800,600)
<<<<<<<<<<<RenderToScreenAsObject src/systems/base/graphics_object_data.cc, 156, alpha == 255, dstRect(700,412,62,22)
<<<<<<<<<<<RenderToScreenAsObject src/systems/base/graphics_object_data.cc, 156, alpha == 255, dstRect(652,436,110,22)
<<<<<<<<<<<RenderToScreenAsObject src/systems/base/graphics_object_data.cc, 156, alpha == 255, dstRect(700,460,62,22)
<<<<<<<<<<<RenderToScreenAsObject src/systems/base/graphics_object_data.cc, 156, alpha == 255, dstRect(700,484,62,22)
<<<<<<<<<<<RenderToScreenAsObject src/systems/base/graphics_object_data.cc, 156, alpha == 255, dstRect(726,508,36,22)
<<<<<<<<<<<RenderToScreenAsObject src/systems/base/graphics_object_data.cc, 156, alpha == 255, dstRect(652,556,110,22)


-----
debug cover bg image parts:
src/systems/base/graphics_object_of_file.cc:88



-----------------===>288, 88 | 800, 600
<<<<<<<<<<<reupload
<<<<<<<<<<<reupload 512, 512
<<<<<<<<<<<uploadBuffer
<<<<<<<<<<<reupload
<<<<<<<<<<<reupload 512, 88
<<<<<<<<<<<uploadBuffer
<<<<<<<<<<<reupload
<<<<<<<<<<<reupload 288, 512
<<<<<<<<<<<uploadBuffer
<<<<<<<<<<<reupload
<<<<<<<<<<<reupload 288, 88
<<<<<<<<<<<uploadBuffer
<<<<<<<<<<<uploadBuffer
-----------------===>512, 512 | 800, 600
--Type <RET> for more, q to quit, c to continue without paging--

Thread 1 "rlvm" hit Breakpoint 4, Texture::Texture (this=0x555556a84550, 
    surface=0x5555569b8c10, x=0, y=0, w=512, h=512, bytes_per_pixel=4, 
    byte_order=32993, byte_type=33639) at src/systems/sdl/texture.cc:210
210	  printf("--->15\n");
(gdb) bt
#0  Texture::Texture(SDL_Surface*, int, int, int, int, unsigned int, int, int)
    (this=0x555556a84550, surface=0x5555569b8c10, x=0, y=0, w=512, h=512, bytes_per_pixel=4, byte_order=32993, byte_type=33639)
    at src/systems/sdl/texture.cc:210
#1  0x00005555556384ac in SDLSurface::TextureRecord::TextureRecord(SDL_Surface*, int, int, int, int, unsigned int, int, int)
    (this=0x555556b73470, surface=0x5555569b8c10, x=0, y=0, w=512, h=512, bytes_per_pixel=4, byte_order=32993, byte_type=33639)
    at src/systems/sdl/sdl_surface.cc:246
#2  0x000055555563dbad in __gnu_cxx::new_allocator<SDLSurface::TextureRecord>::construct<SDLSurface::TextureRecord, SDL_Surface* const&, int&, int&, int const&, int const&, unsigned int&, int&, int&>(SDLSurface::TextureRecord*, SDL_Surface* const&, int&, int&, int const&, int const&, unsigned int&, int&, int&)
    (this=0x555557127760, __p=0x555556b73470)
    at /usr/include/c++/9/ext/new_allocator.h:146
#3  0x000055555563ce0e in std::allocator_traits<std::allocator<SDLSurface::TextureRecord> >::construct<SDLSurface::TextureRecord, SDL_Surface* const&, int&, int&, int const&, int const&, unsigned int&, int&, int&>(std::allocator<SDLSurface::TextureRecord>&, SDLSurface::TextureRecord*, SDL_Surface* const&, int&, int&, int const&, int const&, unsigned int&, int&, int&) (__a=..., __p=0x555556b73470)
    at /usr/include/c++/9/bits/alloc_traits.h:483
#4  0x000055555563d033 in std::vector<SDLSurface::TextureRecord, std::allocator<SDLSurface::TextureRecord> >::_M_realloc_insert<SDL_Surface* const&, int&, int&,--Type <RET> for more, q to quit, c to continue without paging--
 int const&, int const&, unsigned int&, int&, int&>(__gnu_cxx::__normal_iterator<SDLSurface::TextureRecord*, std::vector<SDLSurface::TextureRecord, std::allocator<SDLSurface::TextureRecord> > >, SDL_Surface* const&, int&, int&, int const&, int const&, unsigned int&, int&, int&)
    (this=0x555557127760, __position=non-dereferenceable iterator for std::vector) at /usr/include/c++/9/bits/vector.tcc:449
#5  0x000055555563c4e7 in std::vector<SDLSurface::TextureRecord, std::allocator<SDLSurface::TextureRecord> >::emplace_back<SDL_Surface* const&, int&, int&, int const&, int const&, unsigned int&, int&, int&>(SDL_Surface* const&, int&, int&, int const&, int const&, unsigned int&, int&, int&) (this=0x555557127760)
    at /usr/include/c++/9/bits/vector.tcc:121
#6  0x000055555563a181 in SDLSurface::uploadTextureIfNeeded() const
    (this=0x555557127720) at src/systems/sdl/sdl_surface.cc:628
#7  0x0000555555638d52 in SDLSurface::EnsureUploaded() const
    (this=0x555557127720) at src/systems/sdl/sdl_surface.cc:340

#8  0x0000555555856650 in GraphicsObjectOfFile::LoadFile() (this=
    0x5555569b8af0) at src/systems/base/graphics_object_of_file.cc:88
#9  0x00005555558564ed in GraphicsObjectOfFile::GraphicsObjectOfFile(System&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) (this=0x5555569b8af0, system=..., filename="S_TT_BG00")
    at src/systems/base/graphics_object_of_file.cc:77
#10 0x00005555556e7a2c in GraphicsSystem::BuildObjOfFile(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&)
--Type <RET> for more, q to quit, c to continue without paging--
    (this=0x555555f92860, filename="S_TT_BG00")
    at src/systems/base/graphics_system.cc:965

#11 0x00005555557c87f0 in (anonymous namespace)::objOfFileLoader(RLMachine&, GraphicsObject&, std::string const&) (machine=..., obj=..., val="S_TT_BG00")
    at src/modules/module_obj_creation.cc:77
#12 0x00005555557cd5d2 in std::_Function_handler<void (RLMachine&, GraphicsObject&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&), void (*)(RLMachine&, GraphicsObject&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&)>::_M_invoke(std::_Any_data const&, RLMachine&, GraphicsObject&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&)
    (__functor=..., __args#0=..., __args#1=..., __args#2="S_TT_BG00")
    at /usr/include/c++/9/bits/std_function.h:300
#13 0x00005555557cd418 in std::function<void (RLMachine&, GraphicsObject&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&)>::operator()(RLMachine&, GraphicsObject&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) const
    (this=0x5555560ac688, __args#0=..., __args#1=..., __args#2="S_TT_BG00")
    at /usr/include/c++/9/bits/std_function.h:688
#14 0x00005555557c8ac5 in (anonymous namespace)::objGeneric_0::operator()(RLMachine&, int, std::string)
    (this=0x5555560ac650, machine=..., buf=0, filename="S_TT_BG00")
    at src/modules/module_obj_creation.cc:109
--Type <RET> for more, q to quit, c to continue without paging--
#15 0x0000555555781f9a in RLOp_Void_2<IntConstant_T, StrConstant_T>::Dispatch(RLMachine&, std::vector<std::unique_ptr<libreallive::ExpressionPiece, std::default_delete<libreallive::ExpressionPiece> >, std::allocator<std::unique_ptr<libreallive::ExpressionPiece, std::default_delete<libreallive::ExpressionPiece> > > > const&)
    (this=0x5555560ac650, machine=..., parameters=std::vector of length 2, capacity 2 = {...}) at src/machine/rloperation.h:456
#16 0x0000555555685dbf in RLOperation::DispatchFunction(RLMachine&, libreallive::CommandElement const&) (this=0x5555560ac650, machine=..., ff=...)
    at src/machine/rloperation.cc:108
#17 0x0000555555681e09 in RLModule::DispatchFunction(RLMachine&, libreallive::CommandElement const&) (this=0x5555560ac5d0, machine=..., f=...)
    at src/machine/rlmodule.cc:153
#18 0x000055555566baf7 in RLMachine::ExecuteCommand(libreallive::CommandElement const&) (this=0x7fffffffd5c0, f=...) at src/machine/rlmachine.cc:349
#19 0x000055555575f1f5 in libreallive::CommandElement::RunOnMachine(RLMachine&) const (this=0x555556a83890, machine=...) at src/libreallive/bytecode.cc:471
#20 0x000055555566b4f2 in RLMachine::ExecuteNextInstruction()
    (this=0x7fffffffd5c0) at src/machine/rlmachine.cc:269
#21 0x00005555555d7a74 in RLVMInstance::Run(boost::filesystem::path const&)
    (this=0x7fffffffdc20, gamerootPath=...) at src/machine/rlvm_instance.cc:204
#22 0x00005555555e80d3 in main(int, char**) (argc=1, argv=0x7fffffffe038)
    at src/platforms/gtk/rlvm.cc:319



