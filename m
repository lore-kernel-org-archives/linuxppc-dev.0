Message-ID: <008701c1bf30$72709200$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>,
	"Claus Gindhart" <Claus.Gindhart@pep.de>
References: <21A8AE56EBB6D411A4520060973D360179DD48@pepintercom.pep.de>
Subject: Re: execve system call question
Date: Wed, 27 Feb 2002 10:45:00 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Claus Gindhart

> I assume, that Your code is stuck inside the init process.
> There is an easy to way to find out, if my assumption is right.
> - Use a sash (Statically linked standalone shell) and replace /sbin/init
> with the executable.
> - If You get a prompt now, the execve works o.k, the hangup is inside init
>
> The further proceeding depends on the result of the above test.
>

I tried other thing like /bin/bash and 'hello world' things. but it didnot worked.

Thank you!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
