Message-Id: <v03130301b4d9d82b5416@[10.0.0.55]>
In-Reply-To: <m12NRsU-001SwhC@bucks>
References: <0FQB00A8FULE7R@pmdf-it.hasler.ascom.ch> from
 "Ruedi.Hofer@ascom.ch" at Feb 22, 2000 11:30:42 AM
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 23 Feb 2000 11:58:41 -0800
To: linuxppc-embedded@lists.linuxppc.org
From: Gilbert Coville <gilbert@mvista.com>
Subject: Re: Current state of MPC8260 Linux
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 6:50 PM -0800 2/22/00, diekema_jon wrote:
>	* My observations as to the current state of the MPC8260
>	version of Linux:
>[...]
>	- MontaVista Software, http://www.mvista.com/, and at least one other
>	  company contracted with Dan Malek <dan@netx4.com> to perform the
>	  MPC8260 Linux port.  Dan Malek was heavily involved with the MPC8xx
>	  Linux port, so he was a natural choice to do the MPC8260 port.
>
>[GPL snippet]
>
>	  Therefore, MontaVista software is compelled to release their MPC8260
>	  changes back to the Open Source community, however the timing
>	  isn't defined.  I would expect MontaVista to release these changes
>	  either before or shortly after their MPC8260 work is released.

MontaVista is 100% committed to the open-source philosophy.  In every case
we have released all sources and/or source changes simultaneously with our
product releases.  In some cases, we have distributed early snapshots of work
before actual release.  We intend to continue to do this.  I do not know the
specific schedule for the 8260 work, but I am quite certain that we will be
releasing its source to the open-source community at large.

We also work closely with Dan Malek.  In some cases we've contracted with
him for work, but in most cases we have leveraged his already extensive
efforts.  This has worked well for us, and I believe it has worked well for
Dan.  With Dan's help, we will be making a better effort to get kernel
changes back into the bitkeeper base sooner, rather than later.

However, resources are always limited.  It takes quite a bit of effort to put
all these things together.

This thread comes at an interesting time, as we have recently completed
the 1.0 version of our 8xx cross-development kit.  In fact, the entire
thing is up on our FTP site at:
	ftp://ftp.mvista.com/pub/hhl-ppc_8xx/

I intend to make a more widespread announcement once our website has an
appropriate link to it, but the bits are there now.

Share and enjoy,
Gilbert

--
Gilbert Coville			MontaVista Software Inc.
gilbert@mvista.com		+1 408-328-9208


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
