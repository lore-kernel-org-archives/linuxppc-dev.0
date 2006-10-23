Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5D1C367A5E
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Oct 2006 15:16:30 +1000 (EST)
Subject: Re: [PATCH] Fixed up the OF functions to only do PCI stuff if PCI
	is actually configured
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andy Fleming <afleming@freescale.com>
In-Reply-To: <Pine.LNX.4.61.0610161558500.6266@ld0175-tx32.am.freescale.net>
References: <Pine.LNX.4.61.0610161558500.6266@ld0175-tx32.am.freescale.net>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 15:16:18 +1000
Message-Id: <1161580578.10524.378.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-10-16 at 16:03 -0500, Andy Fleming wrote:
> The original problem that inspired this patch was solved quite some time 
> ago (Turning off PCI didn't work), but this patch neatens things up a 
> little (I think), by putting all the PCI stuff inside a single CONFIG_PCI 
> block.  It also removes the OF PCI bus matching entries if CONFIG_PCI is 
> off.

Looks good to me.

Ben.
