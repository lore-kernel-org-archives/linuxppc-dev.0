Date: Fri, 26 Mar 2004 09:57:48 +0100 (CET)
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	<kernel@plumlocosoft.com>
Subject: Re: O(1) scheduler for PPC?
In-Reply-To: <4063ED30.2020807@imc-berlin.de>
Message-ID: <Pine.LNX.4.44.0403260955170.7016-100000@linpc003.aimsys.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 26 Mar 2004, Steven Scholz wrote:

>
> Jaap-Jan Boor wrote:
>
> > On Thu, 25 Mar 2004, Steven Scholz wrote:
> >>
> >>is the backport of Ingo Molnar's O(1) scheduler in the official linux-2.4.2x
> >>tree and is it available for the PPC?
> >
> > an up-to-date patch together with the preemptible kernel and low-latency
> > patches for 2.4.25 are available here:
> >
> > http://www.plumlocosoft.com/kernel
>
> Thanks a lot.
>
> But it looks like the recent "full patch against 2.4.25" found at
>
> http://www.plumlocosoft.com/kernel/patches/2.4/2.4.25/2.4.25-lck1/patch-2.4.25-lck1.bz2
>
> still got the problems mentioned ages ago in
>
> http://lists.linuxppc.org/linuxppc-dev/200212/msg00032.html
>
> Maybe Eric Hustvedt could merge these trivials into his patch set.
>
> Thanks a million,

Yes, you too, I just (last night) had the build problem with _sched_find_first_bit
and didn't check the changes you mentioned above. I also have not run it yet
on my system.

Jaap-Jan

>
> Steven
>
>
>

--
J.G.J. Boor			  Anton Philipsweg 1
Software Engineer		  1223 KZ Hilversum
AimSys bv              		  tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   mailto:jjboor@aimsys.nl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
