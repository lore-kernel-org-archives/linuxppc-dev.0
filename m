Date: Wed, 4 Jul 2001 21:06:10 -0400
Message-Id: <200107050106.VAA01006@macaron.inria.fr>
From: Jean-Jacques Levy <Jean-Jacques.Levy@inria.fr>
To: k_fukui@highway.ne.jp
Cc: linuxppc-dev@lists.linuxppc.org
In-reply-to: <20010702235152.Postino-013684@smtp01.highway.ne.jp> (message
	from Kaoru Fukui on Mon, 2 Jul 2001 23:51:52 +0900)
Subject: Re: __divdi3 unresolved + X pointer blocks
Reply-To: Jean-Jacques.Levy@inria.fr
References: <200107022031.QAA01037@macaron.inria.fr> <20010702235152.Postino-013684@smtp01.highway.ne.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kaoru,

I installed gcc-3.0 release, and remained with my undefined
__divdi3. Then I patched inode.c in fs/fat and replaced two divisions
by 512 by >> 9. The error disapeared.

Either gcc-3.0 has a bug, either there is a missing module to
implement long divisions (by 512!) in fs/fat.o

Finally my kernel 2.4.6-pre6 (benh) still does not boot on my tibook
but problem must be elsewhere now.

-JJ-

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
