Message-ID: <004701bf78e6$d2ab0de0$0201a8c0@home>
From: "Jeff Millar" <jeff@wa1hco.mv.com>
To: "Graham Stoney" <greyham@research.canon.com.au>
Cc: "LinuxPPC Embedded Mailing List" <linuxppc-embedded@lists.linuxppc.org>
References: <20000217005917.4338F1B580@elph.research.canon.com.au>
Subject: Re: gdb from mbxroot.full.tgz complains: Not a typewriter
Date: Wed, 16 Feb 2000 20:32:01 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


you need Dan Malek's sash patch. In addition, complicated terminal I/O might
be affected by a bug that Pavel Roskin fixed a few days ago (and posted
here).

jeff

----- Original Message -----
From: "Graham Stoney" <greyham@research.canon.com.au>
To: "LinuxPPC Embedded Mailing List" <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, February 16, 2000 7:59 PM
Subject: gdb from mbxroot.full.tgz complains: Not a typewriter


>
> I'm using mbxroot.full.tgz to develop/test a linuxppc-embedded application
on
> an Embedded Planet CLLF board, and I'm having some trouble running its gdb
> on the target. (I'm not using gdbserver here). When I run my program under
> gdb, and it stops at a breakpoint, I get the warning:
>
>     [tcsetpgrp failed in terminal_inferior: Not a typewriter]
>
> after this, gdb no longer accepts my keyboard input.
>
> My guess is that the problem is caused by the kernel simply spawning a
shell
> without starting init, and is probably the same thing that stops CTRL-C
working
> on the console shell. My question then, is this: what's the simplest way
to
> make a shell on the console act like a normal shell on a host machine?
>
> Thanks,
> Graham
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
