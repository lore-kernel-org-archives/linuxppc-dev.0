Message-ID: <3670B354.4AFACB80@jlc.net>
Date: Fri, 11 Dec 1998 00:53:25 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: "Guy G. Sotomayor, Jr." <ggs@shiresoft.com>
CC: Cort Dougan <cort@persephone.cs.nmt.edu>,
        Troy Benjegerdes <hozer@drgw.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP RTC vs Decrementer accuracy...
References: <Pine.LNX.3.96.981208165142.11398A-100000@persephone.cs.nmt.edu> <366EDF74.6EE17E0D@jlc.net> <366F62CC.1C4B225E@shiresoft.com> <36700A9F.C1C99794@jlc.net> <36702079.69588EB4@shiresoft.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Guy G. Sotomayor, Jr. wrote:

> Dan Malek wrote:
> > Excellent idea.  I have started to implement this on an MPC8xx board,
> > so I will let everyone know the results pretty quickly.

> .....this is how we kept time since all of the processors we were
> dealing with had a time base or its moral equivalent.....

I have it running on an MPC8xx board right now, we'll
see how it keeps time overnight with some other programs
running.   I couldn't point to any problems with the decrementer,
but I think my implementation of the TB prevents missing
any counts.  One nice thing I discovered is the decrementer
is an exception rather than an interrupt, so you are unlikely
to mask it like you do with the TB interrupt.

I am working on a version right now that I will run on
my PowerBook G3 to see if I can actually make it  run
on a 750 platform.


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
