Message-Id: <200012040029.eB40TKB27990@denx.local.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 2.4.0-test11 Patches for TQM8xxL etc.
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 03 Dec 2000 21:11:23 +0100."
Date: Mon, 04 Dec 2000 01:29:14 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


For all users of TQM8xxL / ETX_0xx / SM850 / SPD8xxTS / IVM systems:

I've re-synced our development  tree  from  bk://hq.fsmlabs.com:5005.
You can find the necessary patch at

ftp://ftp.denx.de/pub/LinuxPPC/usr/src/patches/linux-2.4.0-test11-2000-12-03.bz2

Please note that the following files  should  be  removed;  they  are
obsolete:

	include/asm-ppc/tqm860.h
	include/asm-ppc/tqm8xxL.h

I have also sent the patch to Dan Malek, hoping it will make it  into
the official source tree.


You can also find a tarball with the new sources at

ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.4.0-test11-2000-12-03.tar.bz2

Also, I've modified scripts/mkdep.c so that you can create a copy  of
the  kernel  source  tree  using  symlinks.  Usually we keep a (write
protected) copy of the original sources in a  central  location,  and
use  a  script  "clone_tree"  to create project-specific copies using
symlinks. This saves a lot  of  disk  space  when  you  have  several
projects / users working in parallel. "clone_tree" can be found at

ftp://ftp.denx.de/pub/LinuxPPC/usr/src/clone_tree


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Shakespeare's Law of Prototyping: (Hamlet III, iv, 156-160)
        O, throw away the worser part of it,
        And live the purer with the other half.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
