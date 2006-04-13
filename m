Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A992F679F4
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 06:53:03 +1000 (EST)
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to
	1GB, V2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Muli Ben-Yehuda <mulix@mulix.org>
In-Reply-To: <20060413173121.GJ10412@granada.merseine.nu>
References: <20060413020559.GC24769@pb15.lixom.net>
	<20060413022809.GD24769@pb15.lixom.net>
	<20060413025233.GE24769@pb15.lixom.net>
	<20060413064027.GH10412@granada.merseine.nu>
	<1144925149.4935.14.camel@localhost.localdomain>
	<20060413160712.GG24769@pb15.lixom.net>
	<20060413173121.GJ10412@granada.merseine.nu>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 06:52:44 +1000
Message-Id: <1144961564.4935.24.camel@localhost.localdomain>
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

On Thu, 2006-04-13 at 20:31 +0300, Muli Ben-Yehuda wrote:
> On Thu, Apr 13, 2006 at 11:07:12AM -0500, Olof Johansson wrote:
> 
> > Walking the DT means we need to hardcode it on PCI IDs, since the Apple
> > OF doesn't give the Airport device a logical name. It's probably easier
> > to implement than walking PCI, but we'd need to maintain a table. My
> > vote is for PCI walking, I'll give that a shot over the weekend.
> 
> Cool! bonus points if you do it in drivers/pci and we can steal it
> easily for Calgary on x8-64 :-)

How so ? Anything remotely related to the iommu is totally different...
Besides, on x86-64, laptops _are_ more common, and thus the problem of
cardbus cards is much more significant.

Ben.
