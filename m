Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7464BDDE00
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Sep 2007 04:34:58 +1000 (EST)
Date: Sun, 16 Sep 2007 20:34:46 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Jon Smirl <jonsmirl@gmail.com>
Message-ID: <20070916183446.GX23573@pengutronix.de>
References: <9e4733910709142038y1bd88cd5s7c9bb21a668db9f6@mail.gmail.com>
	<9e4733910709142128l7a264a05ve68f59aee92b40e3@mail.gmail.com>
	<20070915122218.GB19857@nd47.coderock.org>
	<9e4733910709150855k6ba6dc8fye9762817566208b4@mail.gmail.com>
	<9e4733910709161000i64622520i77caa00e56abc7a8@mail.gmail.com>
	<9e4733910709161005u4f400ab7wb1bf55dac1b45193@mail.gmail.com>
	<9e4733910709161100i456c176ay664d89ac638c9958@mail.gmail.com>
	<9e4733910709161125u15dcd02cj300c0e3a7fda4c0a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <9e4733910709161125u15dcd02cj300c0e3a7fda4c0a@mail.gmail.com>
Subject: Re: Domen's MPC5200 FEC cleanup patch.
Cc: Domen Puncer <domen.puncer@telargo.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Sep 16, 2007 at 02:25:09PM -0400, Jon Smirl wrote:
> Next I'll look at how the pcm030 supplies an Ethernet address. It has
> an EEPROM on the board that holds it. Is this something that can be
> read from of?

If you use our u-boot port, the mac addresses are being written by
u-boot and should already be present when linux comes in.

Robert
-- 
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de
