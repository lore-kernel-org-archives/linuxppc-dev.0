Date: Mon, 31 Jul 2000 18:05:37 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel Dnzer <daenzerm@student.ethz.ch>
cc: Iain Sandoe <iain@sandoe.co.uk>, SteffenH@hyperion-software.de,
        takashi oe <toe@unlserve.unl.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC X Server
In-Reply-To: <3984708A.D2D39371@student.ethz.ch>
Message-ID: <Pine.LNX.4.10.10007311758340.20511-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > >>And yes, there have been reports of people trying it (one yesterday - said
> > >>it was quicker in some places & slower in others...)
>
> He didn't provide any numbers though. For all chipsets which have an
> accelerated driver in X 4, it's almost certainly faster than anything else -
> and also for the others it should be faster than X 3.3.x .

Talking about x11perf on Mach64? It's faster for scrolls and rectcopys but
as fast as the fbdev driver or slightly slower for other stuff. I can send
logs (at 32 bpp) to anyone that cares to analyze them. Switching back to
3.3.x is something I always wanted to do but never found time for, but
even the fbdev driver on 4.01 feels a lot faster than the 3.3.x one.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
