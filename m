Date: Sun, 9 Jul 2000 07:15:07 +1200
From: Gwyn Judd <b.judd@xtra.co.nz>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: X still locks up
Message-ID: <20000709071507.B879@thislove.dyndns.org>
References: <20000707142631.B804@thislove.dyndns.org> <20000707105332.11070@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000707105332.11070@mailhost.mipsys.com>; from bh40@calva.net on Fri, Jul 07, 2000 at 12:53:32PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jul 07, 2000 at 12:53:32PM +0200, Benjamin Herrenschmidt wrote:
> >1) I tried installing the Xpmac.rev10 server that someone recommened in
> >the hope that that would fix the problem. Unfortunately it didn't as
> >five minutes ago the system locked up yet again. This seems to suggest
> >it may be kernel related rather than X related.
> >
> >2) I recompiled my kernel wth the "Magic Sysrq" support in it. This
> >seems to work more or less as designed. However when the system locked
> >up as before the "magic sysrq" key did not work at all meaning I had to
> >reboot without being able to shut down properly. This suggests to me
> >that the kernel had itself crashed.
> >
> >3) When I rebooted there was no kernel panic in the logs. This has me
> >puzzled. I suppose it could have crashed and not had it written out to
> >disk in time. On the otherhand this has happened before and each time
> >there is no panic.
>
> Can you give a try to my current rsync tree (linuxcare.com.au::linux-
> pmac-benh) and tell me if it helps ?

Okay I got that kernel working but it crashed overnight :(. Seems like
the problem is still there. It seems to happen most often when I'm
listening to streaming mp3's (ie. internet radio stations or the like)
if that helps.

--
Gwyn Judd (b.judd@xtra.co.nz)
A citizen of America will cross the ocean to fight for democracy, but
won't cross the street to vote in a national election.

		-- Bill Vaughan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
