Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: now random kernel panics with aic7xxx driver 6.2.4 in kernel 2.4.12
Date: Sun, 14 Oct 2001 19:54:18 -0400
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
References: <200110142053.f9EKq3Y43599@aslan.scsiguy.com>
In-Reply-To: <200110142053.f9EKq3Y43599@aslan.scsiguy.com>
MIME-Version: 1.0
Message-Id: <20011014235202.PYHV2701.tomts7-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Justin,

> It would be interesting to know what type of panics you saw prior
> to 6.2.4.  It might help me track down where this problem began.

This is my first foray into 2.4.X kernels.  I did not have any panics with
the old aic7xxx driver.  I first used 6.2.1 in kernel 2.4.11.  So you
pretty much know the whole story.  The reason I moved to your 6.2.4 was
that at some point I could not even boot 2.4.12 since it came back with:

scsi0:A:1: ahc_intr - referenced scb not valid during seqint 0x71 scb(0)
...
Kernel panic: for safety
In interrupt handler - not syncing
<0>Rebooting in 180 seconds

But the message logs never caught any of the error message since a sync
was not done.

> The card seems to be loosing some of its resources.  I can't say
> why yet.  I think it may be a regression in some of the abort
> code in the kernel.  Could you try running with AHC_DEBUG_SEQUENCER
> enabled?  You can just #define this to 1 in aic7xxx.c.

I have to go out of town tonight but I will rebuild with this define and
send you a full error message log on Wedsnesday.

Thanks, I hope we can get this nailed down.  I really would rather use
your new driver.

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
