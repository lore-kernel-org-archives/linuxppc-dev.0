Return-Path: <rsc@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 5448DDDF74
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 19:12:20 +1100 (EST)
Date: Tue, 3 Mar 2009 09:12:12 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/mpc52xx: add Phytec phyCORE-MPC5200B-IO board
	(pcm032)
Message-ID: <20090303081212.GL5367@pengutronix.de>
References: <20090301101815.GC23093@pengutronix.de>
	<fa686aa40903010648q238380acy34b58e04226d8014@mail.gmail.com>
	<9e4733910903010754q1b4d9fafy87668049653d5e21@mail.gmail.com>
	<fa686aa40903011447x1810f252m367d6c05cc567133@mail.gmail.com>
	<9e4733910903011637q246eb82al140e87242f695413@mail.gmail.com>
	<9e4733910903011646g43b151c2m7c6dfe80ac07e80a@mail.gmail.com>
	<fa686aa40903011707q3c142942w962c52abaf915629@mail.gmail.com>
	<9e4733910903011815q1a956be0x137bac80f2e21e72@mail.gmail.com>
	<9e4733910903011819q105a856n163ccd8fee37d980@mail.gmail.com>
	<fa686aa40903012033x6b6a76d6j7218d076f2c6ad3d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <fa686aa40903012033x6b6a76d6j7218d076f2c6ad3d@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Wolfram Sang <wsa@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Mar 01, 2009 at 09:33:16PM -0700, Grant Likely wrote:
> On Sun, Mar 1, 2009 at 7:19 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> > Would it be easier to get Pengutronix to release a new u-boot for
> > the pcm030? I'm using U-Boot 1.2.0-mpc5200b-tiny-2 (Apr 17 2007 -
> > 11:49:20).
>
> Only if it is a chip IO setup problem (like port_config or clock
> setup). Otherwise the kernel should be setting up the PCI controller
> correctly. Regardless, I don't think the kernel should be crashing
> when PCI is in a funny state.

Ack; I didn't follow the thread in detail, but if possible I'd like to
avoid bootloader updates; it's quite a lot of effort because there are
thousends of devices in the field, not to mention the whole
qualification mechanics at Phytec.

Wolfram can check the issue when being back in the office.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
