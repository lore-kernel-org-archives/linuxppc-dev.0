Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC5200Lite and PCI issues...
Date: Mon, 1 Mar 2004 09:20:12 +0100
References: <20040227085659.B2B2CC0655@atlas.denx.de>
In-Reply-To: <20040227085659.B2B2CC0655@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403010920.12424.g.jaeger@sysgo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Friday 27 February 2004 09:56, Wolfgang Denk wrote:
> In message <200402270935.06816.g.jaeger@sysgo.com> you wrote:
> > while playing around with a Lite5200 eval-board, I noticed that
> > there seems to be some problems with the PCI bus. Some cards
> > are detected without any problems and also can be accessed
> > some cards not. Apart for the 5V/3.3V issues, I think there are
> > some problems with this board.
> > Are there any experiences? Explanations? Solutions, or workarounds?
>
> Remember that there is just one PCI interrupt on the LITE5200;  cards
> that require another one will not work.

Ah I see, thanks for this hint. My major problem seems, that some PCI
cards esp. grafic adapter simply did not appear in the PCI list of i.e.
u-boot. The cards work fine in a EBONY EVA board.
Are there any known problems with PCI timings or is the power supply
the problem?

Regards,
  Gerhard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
