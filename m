Date: Wed, 8 Nov 2000 01:06:10 +1100
From: Steven Hanley <sjh@svana.org>
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: bad vidmode on debian install
Message-ID: <20001108010609.A26617@wibble.net>
Reply-To: Steven Hanley <sjh@wibble.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All

Anyway trying to upgrade form non debian dist to debian (potato) on my
7220/200, as it is old world I used the hfs floppy image. Anyway it boots
fine but then the video mode is at a frequency such that no text is clear
and it is moving around on the screen a bit (like running X i modes a
machine cant handle)

So I think, all I need to do is type the command line in somewhere to set it
to a vidmode I know works on the machine.

However this alas does not seem to work, there is some data that flashes up
in 80x25 before the vidmode switch on booting any kernel wether it be off
floppy or through bootx into the current ydl install. And looking in
arch/ppc/boot/misc.c this seems to be useful and interesting information
including a bit that should wait for 5 seconds for me to enter command line
arguments. Howevedr the information flashes past so fast I cant even read
it. I am then on booting off the debian install floppy put into this
unusable video mode.

I tried changing the #defined CMDLINE in misc.c to have the appropriate
vidmode command, but then I noticed on a simple makevmlinux the make process
didnt even enter the boot directory and compile the changed misc.c (all this
is using a 2.2.18pre18 from paul's ppc.samba.org from yesterday)

What I want to know is what is the official (tm) way in which I am supposed
to put a command line that will actually be used into the kernel for booting
off the debian hfs rescue floppy. I made the image I wanted fine and gzipped the
vmlinux and placed it on the floppy but due to there being no setting of
video mode it still boots into an unreadable text frame buffer.

I assume rdev is specific to i386 and compressed images. I notice the floppy
uses a simple gzipped vmlinux, not a compressed ppc zImage even.

I assume it may help me to know for future reference how to set the kernel
command line if I am no longer using bootx and thus wil be unable to just
leave the command line there.

Thanks

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
