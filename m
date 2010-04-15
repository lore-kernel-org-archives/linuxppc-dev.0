Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.181])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AEF73B6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Apr 2010 20:59:50 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Resetting PCI-E devices after linux boot
Date: Thu, 15 Apr 2010 12:59:27 +0200
References: <4BAC0D4B.3030507@fulcrummicro.com>
	<t2wa8142e731004140655p230f7094idc29e489ea09e848@mail.gmail.com>
	<1271283923.13059.150.camel@pasglop>
In-Reply-To: <1271283923.13059.150.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201004151259.27680.sr@denx.de>
Cc: Jake Magee <jakemagee@gmail.com>, Dan Wilson <dwilson@fulcrummicro.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

On Thursday 15 April 2010 00:25:23 Benjamin Herrenschmidt wrote:
> It should be possible to get that working, but I suspect not without
> some code changes. I know the current PCIe hotswap driver has ACPI hooks
> that would need to be replaced by appropriate hooks into the powerpc
> code to perform the right resource manipulation etc...
> 
> We do PCIe hotswap on IBM pSeries, but this is using specific FW
> interfaces for which we have a dedicated PCI hotplug driver.
> 
> Can the slot power be SW controlled on the Canyonlands PCIe slot ?

No. I just checked the schematics. PCIe power supply is directly connected to 
the board power supplies.

Cheers,
Stefan
