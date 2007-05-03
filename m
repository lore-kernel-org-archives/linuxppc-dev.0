Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 8E1B5DE024
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 03:25:38 +1000 (EST)
Date: Thu, 3 May 2007 12:26:57 -0500
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] 86xx: Enable the AC97 interface on 8641D board.
Message-ID: <20070503172657.GA32312@lixom.net>
References: <1178142818.32136.51.camel@ld0161-tx32>
	<08D3A1CE-12E0-4759-B055-DE227EA4135E@kernel.crashing.org>
	<1178207725.17201.33.camel@ld0161-tx32>
	<20070503161000.GA31881@lixom.net>
	<1178209046.17201.55.camel@ld0161-tx32>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1178209046.17201.55.camel@ld0161-tx32>
From: olof@lixom.net (Olof Johansson)
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 03, 2007 at 11:17:26AM -0500, Jon Loeliger wrote:
> On Thu, 2007-05-03 at 11:10, Olof Johansson wrote:
> 
> > 
> > This sounds like something that firmware should take care of, not
> > hardcoded in the board code.  Seems like the device is just a PCI device
> > that doesn't have a device tree entry.
> 
> Well, it's not a PCI device at all.

Really? You use a PCI quirk to manipulate it.

> > Why not do this in u-boot instead?
> 
> Why do it there?  We'd have to do it _again_ in Linux
> if we didn't come in from U-Boot anyway.

The same argument could be used to motivate not doing any kind of board
inits in any firmware and do it all from the board code in linux.

Don't you guys use M1575 on other eval boards too, so you'll need the
same board quirk duplicated?


-Olof
