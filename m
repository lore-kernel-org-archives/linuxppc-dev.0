Return-Path: <geert@linux-m68k.org>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 4DDDBDDEC2
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 18:59:17 +1000 (EST)
Date: Sun, 3 Jun 2007 10:59:09 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonytel.be
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
In-Reply-To: <20070602085359.GA10333@iram.es>
Message-ID: <Pine.LNX.4.62.0706031058030.29284@pademelon.sonytel.be>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
	<1180734314.5674.49.camel@rhino>
	<4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org>
	<20070602085359.GA10333@iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2 Jun 2007, Gabriel Paubert wrote:
> I have vague memories of a node named i8259@20 one a board 
> who had OF in 1997 (a Motorola MVME but they switched to 
> PPCBUG just after :-().

On my LongTrail (RIP), I used to have /pci/isa@1/interrupt-controller@i20
(http://users.telenet.be/geertu/Linux/PPC/pci/isaAT1/interrupt-controllerATi20/)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
