Date: Fri, 9 Jul 2004 09:36:51 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: error: "lsmod: QM_MODULES: Function not implemented"
Message-ID: <Pine.LNX.4.60.0407090929570.25268@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   (i've asked about this on the busybox list as well, so profuse
apologies to those who see it twice.)

   Scenario:
 	850DE-based board
 	ELDK 3.0
 	latest bk pull of linuxppc-2.5
 	today's snapshot of BB (20040709)

# lsmod
lsmod: QM_MODULES: Function not implemented

   i've configured BB explicitly to support 2.6 modules, and the kernel
also has module support.  historically, when one got this error, the
response was, "hey, you have to upgrade to rusty's latest
'module-init-tools' package, that'll fix it."  but that's clearly not
an option when using BB.  someone on the BB list posted a reference to
a patch that seemed to only fix modprobe, which doesn't help here.

   note that i'm not trying to actually load a module (i don't even
*have* any 2.6-compatible modules to play with yet), but it would be
nice to just get lsmod to work and tell me i have no modules loaded
yet.  thoughts?  i'm currently following the logic flow through BB's
libbb/module_syscalls.c code.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
