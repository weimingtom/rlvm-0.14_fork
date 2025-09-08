xubuntu 20.04 64bit
boost 1.55.0

$ ./bootstrap.sh --show-libraries
    - atomic
    - chrono
    - context
    - coroutine
    - date_time
    - exception
    - filesystem
    - graph
    - graph_parallel
    - iostreams
    - locale
    - log
    - math
    - mpi
    - program_options
    - python
    - random
    - regex
    - serialization
    - signals
    - system
    - test
    - thread
    - timer
    - wave


$ ./bootstrap.sh --with-toolset=gcc --with-libraries=serialization,program_options,iostreams,filesystem,date_time,thread

Building Boost.Build engine with toolset gcc... tools/build/v2/engine/bin.linuxx86_64/b2
Unicode/ICU support for Boost.Regex?... not found.
Generating Boost.Build configuration in project-config.jam...

Bootstrapping is done. To build, run:

    ./b2
    
To adjust configuration, edit 'project-config.jam'.
Further information:

   - Command line help:
     ./b2 --help
     
   - Getting started guide: 
     http://www.boost.org/more/getting_started/unix-variants.html
     
   - Boost.Build documentation:
     http://www.boost.org/boost-build2/doc/html/index.html

$ cat project-config.jam 

$ ./b2 clean
$ ./b2 -d2 toolset=gcc link=static stage

$ ls ./stage/lib
libboost_date_time.a   libboost_program_options.a  libboost_thread.a
libboost_filesystem.a  libboost_serialization.a    libboost_wserialization.a
libboost_iostreams.a   libboost_system.a




