Date: Tue, 11 Jul 2000 12:48:02 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Matt Porter <mmporter@home.com>
cc: Michael Lundkvist <ml@epact.se>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Going from 2.2.12 to 2.2.17pre10
In-Reply-To: <20000710231251.B23538@cx258813-a.chnd1.az.home.com>
Message-ID: <Pine.HPX.4.10.10007111242020.9548-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 10 Jul 2000, Matt Porter wrote:

> > Ok, my queston was rather: does PPCBUG have support for generic IDE
> > interfaces or not ?
>
> Do you mean standard PCI IDE interfaces as in the PCI spec addon?  I'm
> pretty sure that the init code doesn't put the onboard controllers in
> native mode so the Ramix controller on the bus will need massaged to
> get into native mode so it can relocated safely in I/O space.  So,
> the answer is no.

Thanks, this anwers my question.

> > The other change I would like to see in PPCBUG is that it complies with
> > the documentatioon that claims that its services will work when the MMU is
> > enabled. At least on 603e it does not work since it sets the MSR IP bit
> > and then silently crashes in the TLB handlers. I doubt that this would
> > work on a 604 or a 750 either (I did not test it), but if you get an ISI
> > or DSI exception, you are probably screwed too.
>
> :)

Actually I think that the only way it will work is if everything that
PPCBUG accesses is mapped with BATs. But I chose not to use BATs for
simplicity in PrePboot.

> > If people volunteer to write a new MVME bootrom from scratch (or a working
> > OF), I shall be the first in line to get it and flash it in my boards.
> > ppc*BUG* deserves its name, at least the second part :-(
>
> There's a few different bootrom projects in fairly early stages and
> lots of interest from various embedded Linux parties since many
> board manufacturers don't have anything more than VxWorks BSPs for
> their hardware and now want Linux support.  I'm predicting that you'll
> see some usable GPL bootrom frameworks/code come out of this need in
> the near future.  I swear I saw a free OF project forming somewhere
> too.

I would swear it too, but I've lost the pointers.  Actually I thought of
adding more early init code to prepboot (towards which I'm understandably
biased) to get something of this kind running, but I don't have the time.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
