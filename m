Date: Fri, 10 Sep 1999 14:14:20 +1000
Message-Id: <199909100414.OAA07651@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: linuxppc-dev@lists.linuxppc.org
Subject: note about compiling SMP kernels
Reply-to: Paul.Mackerras@cs.anu.edu.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just a quick note for those of you who are trying to compile up a
kernel for an SMP powermac: make sure that you are not using an old
arch/ppc/kernel/ppc_defs.h file from a UP compile.  For instance, my
rsync trees have a version of this file in them which is suitable for
a UP compile.

So, before compiling for SMP for the first time, do a make clean in
the tree first, even if the tree has no object files in it.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
