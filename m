From: kd@flaga.is
Subject: Re: Building PPC cross compiling environment...
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <OF3AC5C978.51A224A0-ON00256838.005F562A@flaga.is>
Date: Mon, 29 Nov 1999 17:37:35 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi,

Number one be shure you have the upto date utils. For example if you want
to compile the Glibc2.1 you need binutils newer than 2.9.4.something. This
applies also to the native tools.
To build the gcc2.95.2 you need a "new" egcs, gcc.2.7.x or egc 1.0.1 will
not do. Be careful to apply the cache patch to the glibc source if you are
building for embedded targets such as mpc823 or mpc860 (posted to the
linuxppc-embedded mailing list). If you have two compilers like in debian
slink (gcc 2.87.x and egcs), export the CC variable to use the egcc
compile, e.g.
export CC=egcc.
I believe tthat the gcc2.7.x is the default compiler in many systems
because egcs had problems compiling the kernel for some systems.

It is also a good idea to build the utils,compilers and libs in another
directory. I.e. at the same directorylevel as (e.g.) binutils-2.9.4 do
mkdir binbuild
cd binbuild
../binutils-2.9.4/configure --target=powerpc-linux --host=i586-linux
--prefix=/usr
make
make install

Hope that this is of some help

K.D.



                                                                                                                                               
                    "Steven J. Hill"                                                                                                           
                    <sjhill@plutonium.net>             To:     linuxppc-dev@lists.linuxppc.org                                                 
                    Sent by:                           cc:                                                                                     
                    owner-linuxppc-dev@lists.li        Subject:     Building PPC cross compiling environment...                                
                    nuxppc.org                                                                                                                 
                                                                                                                                               
                                                                                                                                               
                    11/29/99 04:13 PM                                                                                                          
                                                                                                                                               
                                                                                                                                               





Greetings.

I am attempting to build a cross compiling environment for PPC under
my RH 6.1 Linux system. I am new at this, however, I looked through
the mailing list archives, DejaNews, and a few other FAQs and was
unable to find anything on this. This my first attempt at this, I
beg for your patience. Please reply to me personally as I am not
subscribed to the list currently. Thanks.

-Steve

***********************************

configure --prefix=/usr --host=i386-linux-gnu --target=powerpc-linux
Created "Makefile" in /tmp/binutils-2.9.1.0.19a using "mt-frag"
collect2: ld returned 33 exit status
*** The command '/usr/bin/gcc -o conftest -g -O2   conftest.c' failed.
*** You must set the environment variable CC to a working compiler.

***********************************


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
