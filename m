To: linuxppc-dev@lists.linuxppc.org
Subject: missing public symbol in glibc/sysdeps/powerpc/elf
Reply-To: minyard@acm.org
From: minyard@acm.org
Date: 22 Aug 1999 22:58:59 -0400
Message-ID: <m2wvungq30.fsf@morse.concentric.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm not sure where to report this, but it is something missing in the
powerpc version of glibc.  In the file
glibc/sysdeps/powerpc/elf/start.S, the __data_start variable is not
global, but it should be (at least it is for i386).  The weak alias
data_start is available, but that is pretty dangerous to use.  I need
this to get the boehm garbage collector working for libgcj.

Corey

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
