Date: Mon, 26 Apr 1999 13:31:43 +0200
From: massin@col.bsf.alcatel.fr (Raphael Massin)
Message-Id: <199904261131.NAA02701@c5s144.clb>
To: linuxppc-dev@lists.linuxppc.org
Subject: egcs-1.1.2
Cc: massin@cabs40
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

I am currently trying to build the cross compiler egc-1.1.2 on a Solaris 2.5.1
machine for a powerpc-eabi target. I have the following error: 'can't find
include file stdlib.h' and 'unistd.h' during the build of libgcc2.

I modified 'configure' to define inhibit_libc, and it works, but there is
a problem later. I feel i should succeed in building the compiler without
making any modifications in the Makefile. Can anybody help me, please ?

	Raphael

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
