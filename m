Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC06145@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: CROSS COMPILER BUILD: Stupid gcc libc++ question
Date: Fri, 31 Jan 2003 15:00:11 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I finally have my compiler compiling compile with glibc ... well mostly I
think ... compilers are put in my bin folder ... but I have library troubles
...

Now I have a problem which I can't find a nice clean reference for ...

When I build with --enable-languages=c,c++ ... build seems to complete but
has problems with ...

make[2]: Entering directory
`/home/jgdon/ppcgcc/gcc-glibc/powerpc-linux/libiberty'
make[2]: *** No targets specified and no makefile found.  Stop.
make[2]: Leaving directory
`/home/jgdon/ppcgcc/gcc-glibc/powerpc-linux/libiberty'
make[1]: *** [../libiberty/libiberty.a] Error 2
make[1]: Leaving directory
`/home/jgdon/ppcgcc/gcc-glibc/powerpc-linux/libstdc++'
make: *** [all-target-libstdc++] Error 2

Is this likely because I haven't compiled libstdc++-3.0 ? Any tips would be
greatly appreciated ?

GCC_VER=2.95.3
gcc-core-$GCC_VER.tar.gz
gcc-g++-$GCC_VER.tar.gz

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
