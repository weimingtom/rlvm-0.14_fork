(gdb) b SDLTextSystem::RenderGlyphOnto
Breakpoint 1 at 0x5555555f6b2e: file src/systems/sdl/sdl_text_system.cc, line 93.
(gdb) c
Continuing.

Thread 1 "rlvm" hit Breakpoint 1, SDLTextSystem::RenderGlyphOnto (this=
    0x7fffffffd0c0, current="", font_size=21845, italic=228, font_colour=..., 
    shadow_colour=0x7fffffffd128, insertion_point_x=0, insertion_point_y=39, 
    destination=<error reading variable: Cannot access memory at address 0xb>)
    at src/systems/sdl/sdl_text_system.cc:93
93	    const std::shared_ptr<Surface>& destination) {
(gdb) bt
#0  SDLTextSystem::RenderGlyphOnto(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, int, bool, RGBColour const&, RGBColour const*, int, int, std::shared_ptr<Surface> const&)
    (this=0x7fffffffd0c0, current="", font_size=21845, italic=228, font_colour=..., shadow_colour=0x7fffffffd128, insertion_point_x=0, insertion_point_y=39, destination=<error reading variable: Cannot access memory at address 0xb>)
    at src/systems/sdl/sdl_text_system.cc:93
#1  0x000055555573ce49 in TextWindow::DisplayCharacter(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&)
    (this=0x5555569271d0, current="網", rest="膜を焼かれるよりはやく、") at src/systems/base/text_window.cc:563
#2  0x00005555558565d6 in TextPage::CharacterImpl(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&)
    (this=0x5555576323d8, c="網", rest="膜を焼かれるよりはやく、")
    at src/systems/base/text_page.cc:433
#3  0x00005555558559e2 in TextPage::Character(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&)
    (this=0x5555576323d8, current="網", rest="膜を焼かれるよりはやく、") at src/systems/base/text_page.cc:334
--Type <RET> for more, q to quit, c to continue without paging--
e&, bool&) (this=0x555557633b40, machine=..., paused=@0x7fffffffd357: false) at src/long_operations/textout_long_operation.cc:164
#5  0x000055555576e733 in TextoutLongOperation::operator()(RLMachine&) (this=0x555557633b40, machine=...) at src/long_operations/textout_long_operation.cc:212
#6  0x0000555555648901 in RLMachine::PerformTextout(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&)
    (this=0x7fffffffd620, cp932str="\226Ԗ\214\202\360\217Ă\251\202\352\202\351\202\346\202\350\202͂₭\201A") at src/machine/rlmachine.cc:590
#7  0x0000555555648750 in RLMachine::PerformTextout(libreallive::TextoutElement const&) (this=0x7fffffffd620, e=...) at src/machine/rlmachine.cc:560
#8  0x000055555575a561 in libreallive::TextoutElement::RunOnMachine(RLMachine&) const (this=0x5555565edcf0, machine=...) at src/libreallive/bytecode.cc:363
#9  0x0000555555646ad8 in RLMachine::ExecuteNextInstruction() (this=0x7fffffffd620) at src/machine/rlmachine.cc:269
#10 0x00005555555d2c63 in RLVMInstance::Run(boost::filesystem::path const&) (this=0x7fffffffdc00, gamerootPath=...) at src/machine/rlvm_instance.cc:177
#11 0x00005555555e6223 in main(int, char**) (argc=1, argv=0x7fffffffe018) at src/platforms/gtk/rlvm.cc:223


sdl_surface.cc
alphablit.cc

