Message-Id: <20010702235152.Postino-013684@smtp01.highway.ne.jp>
Date: Mon, 2 Jul 2001 23:51:52 +0900
To: Jean-Jacques.Levy@inria.fr
Cc: linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: __divdi3 unresolved + X pointer blocks
In-Reply-To: <200107022031.QAA01037@macaron.inria.fr>
References: <200107022031.QAA01037@macaron.inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Jean-Jacques Levy <Jean-Jacques.Levy@inria.fr>
To: linuxppc-dev@lists.linuxppc.org
Subject: __divdi3 unresolved + X pointer blocks
Date: Mon, 2 Jul 2001 16:31:55 -0400

>
> When compiling linux.2.4.6-pre6 (benh kernel), I get undefinded symbol
> __divdi3 in the fat.o module.  When I suppress module fat.o, kernel
> doesn't boot.  Please help! (My c-compiler is gcc-3.0-20010427pre_0a,
> libc is glibc-2.1.3-15f.)

Plaese update gcc-3.0 release or current gcc-3.0.1.pre from cvs.

I guess,our powerpc kernel doen't use __divdi3 ,
then I could not see the symbol when on top kernel source
I did
 grep -rn __divi3 *


Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
