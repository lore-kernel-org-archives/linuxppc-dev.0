Date: Fri, 18 Jun 1999 17:18:19 +1000
Message-Id: <199906180718.RAA11040@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: linuxppc-users@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: precompiled 2.2.10 kernel available
Reply-to: Paul.Mackerras@cs.anu.edu.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have put a precompiled 2.2.10 powermac kernel on dev.linuxppc.org
and on samba.anu.edu.au (accessible only from within Australia).  This
kernel works on the iMac and should work on the blue&white G3
powermac, although I haven't been able to test it directly myself.

The source for this kernel is available as a .tar.gz file on the two
ftp servers or by anonymous rsync from
samba.anu.edu.au::linux-pmac-stable.  (My current 2.3.6 tree is
available by anon rsync at samba.anu.edu.au::linux-pmac-devel.)

*NOTE:* This kernel includes Linus' USB stack, which (in my version)
translates the USB keycodes to ADB keycodes.  If you have an iMac, or
a B&W G3 with a USB keyboard, comment out (or change) the KEYTABLE
definition in /etc/sysconfig/keyboard so that your init scripts don't
load a USB keymap.

The relevant files are in ftp://dev.linuxppc.org/users/paulus or
ftp://samba.anu.edu.au/pub/linux-pmac/.  They are:

In kernel-binary/v2.2.10:
   vmlinux			kernel binary (ELF)
   vmlinux.gz			gzipped version of vmlinux
   System.map			symbol table for vmlinux
   modules-2.2.10.tar.gz	kernel modules, unpack in /
   dot.config			.config file used to build vmlinux

kernel-source/v2.2.10/linux-pmac-2.2.10.tar.gz
		kernel source tree, tarred & gzipped

RPMS/pcmcia-cs-3.0.12-2210.ppc.rpm
		PCMCIA kernel modules & user programs
		(compiled against glibc-1.99, i.e. Linux/PPC R4)

SRPMS/pcmcia-cs-3.0.12-2210.src.rpm
		Source for PCMCIA support

Enjoy!

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
