Date: Thu, 1 Feb 2001 18:48:06 +1100
From: Steven Hanley <sjh@svana.org>
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: agpgart? or how to use dri?
Message-ID: <20010201184806.A5957@chiru.svana.org>
Reply-To: Steven Hanley <sjh@wibble.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All

Trying to get the dri stuff to build (this is an X 4.02 tree checked out
from the branch Gareth announced two days ago)

The problem seems to be the kernel module. When I have agpgart enabled in
the kernel the r128 kernel module builds, when I dont have apgart enabled
only the tdfx module will build, this is doing a make in the
xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/ directory in the
X source

The problem here of course is agpgart wont build on ppc

in /usr/src/linux/drivers/char/agp/agpgart_be.c there is a flush_dcache
function defined, and it is only defined for alpha, ia64 and i386.

I dont know what the culprit is, but I assume thee dri stuff can be built
without agpgart on ppc or some scuh, this kernel tree is the 2.4.1 bk
rsynced about half an hour ago.

Any hints on getting the dri kernel module to build to the extent that it
can be insmod'd and used?

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh
Look Up In The Sky
    Is it a bird?   No
        Is it a plane    No
            Is it a small blue banana?
Yes

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
