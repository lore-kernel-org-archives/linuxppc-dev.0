Message-ID: <36700A9F.C1C99794@jlc.net>
Date: Thu, 10 Dec 1998 12:53:36 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: "Guy G. Sotomayor, Jr." <ggs@shiresoft.com>
CC: Cort Dougan <cort@persephone.cs.nmt.edu>,
        Troy Benjegerdes <hozer@drgw.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP RTC vs Decrementer accuracy...
References: <Pine.LNX.3.96.981208165142.11398A-100000@persephone.cs.nmt.edu> <366EDF74.6EE17E0D@jlc.net> <366F62CC.1C4B225E@shiresoft.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Guy G. Sotomayor, Jr. wrote:

> Umm, but why are you keeping track of time with the decrementer?

Because that is the way it was done when I first looked at the kernel
a long time ago :-).


> .....use the timebase to keep track of time and the decrementer
> to deliver periodic interrupts?

Excellent idea.  I have started to implement this on an MPC8xx board,
so I will let everyone know the results pretty quickly.

It appears the TB is part of every PPC core.  If anyone knows different
please let me know.

    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
