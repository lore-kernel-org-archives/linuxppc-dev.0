Message-ID: <D73A25AA6E54D511AD74009027B1110F3C0927@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Kent Borg'" <kentborg@borg.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Heretical Question
Date: Wed, 9 Jul 2003 16:09:01 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ddd will let you specify a gdb debugger to use. You have to add -g -ggdb to
the CFLAGS and compile the kernel.  Then give the command

ddd --debugger ppc_8xx-gdb vmlinux

Replace ppc_8xx-gdb with your debugger of choice, gdb is the default if you
do not specify.

-----Original Message-----
From: Kent Borg [mailto:kentborg@borg.org]
Sent: Wednesday, July 09, 2003 3:57 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Heretical Question



I know it is wrong for me to ask, but is there (possibly already
lurking in my Red Hat box?) a graphical front end to GDB that will
work with embedded programming?  Emacs already lets me debug with
source code pretty well (not assembly, however), and that is nice, but
what I really miss is a way to browse through data structures.  Kdbg
looks good, but it seems to be for native debugging only (though I
might hack at it a little to issue the elusive "target remote ...").
It is possible ddd would do, but it also seems to be for native
debugging only too.

Suggestions?


Thanks,

-kb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
