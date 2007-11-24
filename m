Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 224BADDDD6
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 07:50:29 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 avorontsov@ru.mvista.com
Subject: Re: [RFC][PATCH 0/3] OF-platform PATA driver
Date: Sat, 24 Nov 2007 21:50:07 +0100
References: <20071123175229.GA27143@localhost.localdomain>
In-Reply-To: <20071123175229.GA27143@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711242150.09812.arnd@arndb.de>
Cc: linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
	Jeff Garzik <jeff@garzik.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 23 November 2007, Anton Vorontsov wrote:
> Here is the PATA Platform driver using OF infrastructure.
> 
> Mostly it's just a wrapper around a bit modified pata_platform
> driver.

Thanks a lot for doing this. Patches 2/3 are what I tried to get
people to do for some time now but was too lazy to do myself.

As a further thought, do the drivers now still need to be
pata specific, or should the OF part be called ata_of_platform
instead and also be used for sata devices?

	Arnd <><
