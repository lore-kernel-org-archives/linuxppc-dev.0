Message-ID: <36702079.69588EB4@shiresoft.com>
Date: Thu, 10 Dec 1998 11:26:50 -0800
From: "Guy G. Sotomayor, Jr." <ggs@shiresoft.com>
MIME-Version: 1.0
To: Dan Malek <dmalek@jlc.net>
CC: Cort Dougan <cort@persephone.cs.nmt.edu>,
        Troy Benjegerdes <hozer@drgw.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP RTC vs Decrementer accuracy...
References: <Pine.LNX.3.96.981208165142.11398A-100000@persephone.cs.nmt.edu> <366EDF74.6EE17E0D@jlc.net> <366F62CC.1C4B225E@shiresoft.com> <36700A9F.C1C99794@jlc.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Dan Malek wrote:
> 
> Guy G. Sotomayor, Jr. wrote:
> 
> > Umm, but why are you keeping track of time with the decrementer?
> 
> Because that is the way it was done when I first looked at the kernel
> a long time ago :-).
> 
> > .....use the timebase to keep track of time and the decrementer
> > to deliver periodic interrupts?
> 
> Excellent idea.  I have started to implement this on an MPC8xx board,
> so I will let everyone know the results pretty quickly.
> 
> It appears the TB is part of every PPC core.  If anyone knows different
> please let me know.
> 
I haven't looked into how the various Linux ports deal with time, but back
when I was doing microkernel work (for a large computer company with a 3
letter name) this is how we kept time since all of the processors we were
dealing with had a time base or its moral equivalent.  This was necessary
since we didn't use the decrementer to deliver fixed period interrupts and
trying keep time from drifting would have been hard.

TTFN - Guy

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
