Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E766E67AAF
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Feb 2005 15:33:30 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050208164042.6dd6fcb0.davem@davemloft.net>
References: <1106028614.4533.69.camel@gaston>
	<20050208164042.6dd6fcb0.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 09 Feb 2005 15:32:50 +1100
Message-Id: <1107923570.7686.94.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sungem update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

> Sorry for taking so long to review this :-/

No worries.

> This looks fine, except for one thing.  The WOL_* registers don't exist
> in the Sun variants of the GEM chip, so it's not safe to try and program
> them on all chips blindly like these changes do.  Perhaps some bit test
> like:
> 
> 	if (pdev->vendor != PCI_VENDOR_ID_SUN)
> 		gp->flags |= GEM_HAS_WOL;
> 
> Then protect all the WOL_* register programming with this new
> GEM_HAS_WOL flag.

Ok, I'll have a look.

Ben.
