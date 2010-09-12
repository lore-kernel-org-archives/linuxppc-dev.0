Return-Path: <andre.schwarz@matrix-vision.de>
Received: from mail1.matrix-vision.com (mail1.matrix-vision.com [78.47.19.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "localhost", Issuer "localhost" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1ACBDB6F10
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Sep 2010 01:10:46 +1000 (EST)
Subject: Re: How to define an I2C-to-SPI bridge device ?
From: =?ISO-8859-1?Q?Andr=E9?= Schwarz <andre.schwarz@matrix-vision.de>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20100910182815.GH11284@angua.secretlab.ca>
References: <1283502979.17812.22.camel@swa-m460>
	<20100903120858.GA19380@oksana.dev.rtsoft.ru>
	<4C84D334.6060008@matrix-vision.de>
	<c843f864-2a5a-4146-bd95-13c2fb91f430@email.android.com>
	<1284106293.2267.42.camel@swa-m460>
	<20100910173706.GD11284@angua.secretlab.ca>
	<1284142484.2152.18.camel@swa-e6500>
	<20100910182815.GH11284@angua.secretlab.ca>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 12 Sep 2010 17:10:35 +0200
Message-ID: <1284304235.2913.8.camel@swa-e6500>
Mime-Version: 1.0
Cc: LinuxPPC List <linuxppc-dev@ozlabs.org>,
	DevTreeDiscuss <devicetree-discuss@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant, Anton,

[snip]

> > 
> > Doing this in parallel will speed things up significantly.
> 
> Yeah; Then I would handle it as a separate cs# and map it to enabling
> multiple CS lines at a time.

sounds reasonable - will do it that way.

> 
> > BTW: would "drivers/misc" be a proper location ?
> > Who's supposed to pick that driver up and on what list shall I post it
> > for review ?
> 
> You should cc spi-devel-general, and feel free to cc me.  drivers/misc
> would probably be an okay place for it to live; but if it only appears
> on a single machine, then it may make more sense in
> arch/*/<board-directory>.  What arch or SoC is this running on?


ok - currently I'm preparing bring up of a MPC8377 based system.
But we have this chips on multiple boards and also on generic PCIe
grabber cards running on any desktop PC.

Since we could use the driver directly after registering the various I2C
masters I'd prefer to go with drivers/misc. After all it's a simple I2C
slave device usable by anyone ...


Will send an initial patch for review after basic verification with real
hardware.


Thanks for your help.

Cheers,
André




MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
