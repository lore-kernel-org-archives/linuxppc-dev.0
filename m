Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 58F9BDDFE8
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 02:17:47 +1000 (EST)
Subject: Re: [PATCH] 86xx: Enable the AC97 interface on 8641D board.
From: Jon Loeliger <jdl@freescale.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070503161000.GA31881@lixom.net>
References: <1178142818.32136.51.camel@ld0161-tx32>
	<08D3A1CE-12E0-4759-B055-DE227EA4135E@kernel.crashing.org>
	<1178207725.17201.33.camel@ld0161-tx32>
	<20070503161000.GA31881@lixom.net>
Content-Type: text/plain
Message-Id: <1178209046.17201.55.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 03 May 2007 11:17:26 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-03 at 11:10, Olof Johansson wrote:

> 
> This sounds like something that firmware should take care of, not
> hardcoded in the board code.  Seems like the device is just a PCI device
> that doesn't have a device tree entry.

Well, it's not a PCI device at all.

> Why not do this in u-boot instead?

Why do it there?  We'd have to do it _again_ in Linux
if we didn't come in from U-Boot anyway.

jdl
