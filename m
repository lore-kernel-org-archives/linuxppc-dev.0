Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC05FDA@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Compiling ULibc and gcc questions
Date: Tue, 7 Jan 2003 19:33:11 -0500 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
I have been looking at compiling uClibc ...

I just got it to compile ...

But now I have some questions regard gcc ... up until now I have been able
to get along fine with a boot strapped version of gcc ...

I now have these questions:

1.) After I build uClibc ... should I recompile gcc with uClibc ?
2.) When I built my boot strap gcc is the "--enable-shared" a good idea to
have? Can some explain if have this feature is good for embedded systems ...
I have some old emails saying "no" ...

Regards,
Jim





I got uClibc to build once I removed the PIC support from the config ... and
pointed the build to my correct kernel source ;-)

Is it importanted to build with " --enable-shared" ?

Jim

-----Original Message-----
From: James Don
Sent: Tuesday, January 07, 2003 6:54 PM
To: 'uclibc@uclibc.org'
Subject: RE: Help: Simple newbie build problem

Ok I think I know what this problem is ... I think it has to do with the way
I built my compiler ... I believe it has to do with the fact I did not build
gcc with the " --enable-shared" option ...

Any one know for sure?

I will keep reading ...

Jim



-----Original Message-----
From: James Don
Sent: Tuesday, January 07, 2003 6:31 PM
To: 'uclibc@uclibc.org'
Subject: Help: Simple newbie build problem

Hello,

Just hoping to find some help with a simple build problem I an having with
uClib.

First off here's some facts:
1.) I have built cross compilers 2.95.3 ... powerpc-linux-gcc with newlib
... etc
2.) I have build bootloader and kernel for embedded board ...
3.) Now I am building uClibc ... I changed the rules.mak file to have the
right CROSS=powerpc-linux- ...

Now here's my problem:
1.) I do this make defconfig
2.) Then I do this make
3.) Then I see this:
	powerpc-linux-ld: cannot open
/home/jgdon/ppcgcc/lib/gcc-lib/powerpc-
	linux/2.95.3/pic/crtbeginS.o: No such file or directory
	make[1]: *** [shared] Error 1
	make[1]: Leaving directory `/home/jgdon/ppcUClibc/uClibc
0.9.16/libpthread'

I have found the file crtbeginS.o in home/jgdon/ppcgcc/lib/gcc-lib/powerpc-
linux/2.95.3/ ... or one directory back of where my build is looking ...

Any advice would be much appreciated,
Jim


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
