Content-Type: text/plain;
  charset="iso-8859-1"
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC5200Lite and PCI issues...
Date: Mon, 1 Mar 2004 10:56:29 +0100
References: <20040301091304.6AF90C0655@atlas.denx.de>
In-Reply-To: <20040301091304.6AF90C0655@atlas.denx.de>
MIME-Version: 1.0
Message-Id: <200403011056.29515.g.jaeger@sysgo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Monday 01 March 2004 10:12, Wolfgang Denk wrote:
> In message <200403010920.12424.g.jaeger@sysgo.com> you wrote:
> > Ah I see, thanks for this hint. My major problem seems, that some PCI
> > cards esp. grafic adapter simply did not appear in the PCI list of i.e.
> > u-boot. The cards work fine in a EBONY EVA board.
>
> Are these really 3.3V cards? (sorry, I don't  know  the  ebony  board
> that well)

Yes.

> > Are there any known problems with PCI timings or is the power supply
> > the problem?
>
> There is a known issue with SDRAM  timings  which  probably  explains
> most  of  the  problems  people  experience,  but I don't think it is
> related to your PCI troubles.

Probably not, but can you be more specific on that SDRAM problems, any known
workarounds?

Regards,
  Gerhard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
