Message-ID: <3AF86649.A5351CD5@routefree.com>
Date: Tue, 08 May 2001 14:34:01 -0700
From: David Blythe <blythe@routefree.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
References: <Pine.HPX.4.10.10105072359470.22253-100000@gra-ux1.iram.es> <3AF72CA8.52163E55@mvista.com> <03a001c0d74e$60022c70$4b00000a@foolio1> <3AF73161.26986237@mvista.com> <040a01c0d754$1bf6d5c0$4b00000a@foolio1> <3AF740C0.F65FBCB8@mvista.com> <047301c0d75c$2da00a00$4b00000a@foolio1> <3AF747C4.9C2D74A5@mvista.com> <3AF8348F.FEBF22DE@routefree.com> <3AF856AE.80D0C230@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
>
> David Blythe wrote:
>
> > ....  However, we
> > can only make it happen on our 405GP walnut board(s) and not our
> > prototype 405GP board(s) (they both have rev D processors).
>
> Oh, great :-).....Are there any obvious differences, like clock
> speed, memory type or configuration, etc.?

Yes, there are some differences.  Memory speed is slower at the moment
(board is still in bringup stage).  There are other subtle differences
as well.  I believe Brian also saw the bug on a non-walnut 405GP.  I was
kinda hoping it was specific to some hardware, but i don't see any
pattern.  It seems that the bug is very sensitive to timing, at least
from watching it seeminly disappear as Eli made small changes to the
atomic ops or related code, as well as Brian's comments about using the
non-inline form of the atomic ops.

>
> If someone gets a chance, would you give the FSM labs linuxppc_2_5
> sources a whirl before they disappear?  I don't expect it to be
> perfect, but it would sure be nice debugging something else for
> a change :-).

Should it run out of the box?  I can give it a try if you have some
confidence it should build and and run a shell on a walnut board.

	thanks
	david

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
