Message-ID: <37DC8FE8.E1ED6636@ctam.com.au>
Date: Mon, 13 Sep 1999 15:47:20 +1000
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: LinuxPPC: porting to new platforms
References: <37DC6656.2A40D04D@ctam.com.au> <37DC7E94.946FBA49@jlc.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> Brendan Simon wrote:
> >
> > I've been trying to get linuxppc running on a Motorola ADS board for
> > some time now.  It seems that the ADS/FADS boards are quite horrible
> > from the mail I've read on this list.  I have now decided to take the
> > plunge and port it to a custom MPC860 board.
>
> So, why don't you just consider the rest of the message I wrote
> and buy a board with Linux/PPC already running?

1) We have two custom boards running a commercial RTOS which is very
expensive.  I plan to replace this RTOS with Linux and maybe RealTimeLinux at
a later stage.  Since these boards are my eventual target, I do not want to
waste any more time getting things working on other boards.

2) The ADS board that I have access to is a loan to us (at no cost).  I am
trying to convince my boss that Linux is the way to go but I don't think I can
justify buying another MPC860 board when we have three different boards
(including the ADS) that seem to work.  The ADS might be suspect but the
commercial evaluation software we've run _appears_ to work ok.


> > .... I am playing around with the 2.2.11 kernel sources which
> > I got from a kernel mirror.  I notice that the support for BSE and RPX
> > boards is not in this source.  Are there some PPC specific kernel
> > archives I should be getting instead ?
>
> Since I have had so much trouble just keeping up with the CVS
> changes, I am way behind with updates.  Before I start updates,
> I always put a tar image of the source tree on the linuxppc.cs.nmt.edu
> server embedded directory.  You will find both 2.2.5 and 2.3.10
> there right now, with the support for BSE and RPX boards.

I can imagine.  There seems to be a LOT happening in the LinuxPPC world.


> I tend to work in the experimental kernels.  Everyone I work with
> or talk to wants the features (and bug fixes) found in the latest
> kernels.
>
> I am nearly ready to post the first 8240 and 8260 changes.  The
> 8260 is an extension of the 8xx stuff today.  The 8xx is somewhat
> changed to accomodate this, and will be in the 2.3.x kernels.
> Use the 2.3.10 tar image from the server.

OK.  Great news about the 82XX stuff.  We are planning on using this in a new
product.  We have been  lucky enough to get a couple of samples.  What is the
latest with regards to silicon bugs in the 82XX series ?  What revision have
you been working with ?

Thanks,
Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
