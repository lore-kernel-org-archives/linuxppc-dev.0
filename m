Date: Mon, 2 Jul 2001 16:31:55 -0400
Message-Id: <200107022031.QAA01037@macaron.inria.fr>
From: Jean-Jacques Levy <Jean-Jacques.Levy@inria.fr>
To: linuxppc-dev@lists.linuxppc.org
Subject: __divdi3 unresolved + X pointer blocks
Reply-To: Jean-Jacques.Levy@inria.fr
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


When compiling linux.2.4.6-pre6 (benh kernel), I get undefinded symbol
__divdi3 in the fat.o module.  When I suppress module fat.o, kernel
doesn't boot.  Please help! (My c-compiler is gcc-3.0-20010427pre_0a,
libc is glibc-2.1.3-15f.)

Second (disconnected) problem: when running X11 4.0.99.3
on my tibook with 2.4.5-pre3g4, the pointer is blocked when kde
starts. After snooze+wakeup, the pointer get unblocked and the
system works? Big thanks for any idea.

-JJ-

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
