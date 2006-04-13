Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2840667DBC
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 20:47:49 +1000 (EST)
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to
	1GB, V2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Muli Ben-Yehuda <mulix@mulix.org>
In-Reply-To: <20060413064027.GH10412@granada.merseine.nu>
References: <20060413020559.GC24769@pb15.lixom.net>
	<20060413022809.GD24769@pb15.lixom.net>
	<20060413025233.GE24769@pb15.lixom.net>
	<20060413064027.GH10412@granada.merseine.nu>
Content-Type: text/plain
Date: Thu, 13 Apr 2006 20:45:49 +1000
Message-Id: <1144925149.4935.14.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-04-13 at 09:40 +0300, Muli Ben-Yehuda wrote:
> On Wed, Apr 12, 2006 at 09:52:33PM -0500, Olof Johansson wrote:
> 
> > iommu=off can still be used for those who don't want to deal with the
> > overhead (and don't need it for any devices).
> 
> I've been pondering walking the PCI bus before deciding to enable an
> IOMMU and checking each device's DMA mask. Is this something that you
> considered and rejected, or just something no one got around to doing?

It would do the trick for airport cards in G5s.. a little bit of OF
walking to find the card.

It won't help with cardbus broadcom's but then, there is currently no G5
with a cardbus adaptor that I know of :) It's possible I suppose to get
a pci<->cardbus adapter but I suppose in that case, we can ignore it ...

Ben.
