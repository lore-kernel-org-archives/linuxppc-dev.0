Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 025CFDDFB4
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 07:11:35 +1000 (EST)
Subject: Re: [PATCH] PowerPC: Add BCM5248 and Marvell 88E1111 PHY support
	to NEW EMAC.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <4713B9C1.5010001@garzik.org>
References: <20071015175717.GA4602@ru.mvista.com> <4713B10B.5000607@garzik.org>
	<20071015134813.6aacdcca@weaponx.rchland.ibm.com>
	<4713B726.6080404@garzik.org>
	<20071015135959.5b603d7d@weaponx.rchland.ibm.com>
	<4713B9C1.5010001@garzik.org>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 07:05:23 +1000
Message-Id: <1192482323.11795.38.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-10-15 at 15:04 -0400, Jeff Garzik wrote:
> I would ideally like a single active patch generator (even if they
> are 
> merely reviewed others work sometimes).
> 
> Outside of that, I'm hoping you and the other people listed making 
> changes will self-organize without my help :)

Josh, do you want to be the central point / maintainer for it or do you
want me to do it ? There's a lot of code from me in there and I did this
fork in the first place so I have a pretty good idea of what's going on
in this driver and what still needs to be done :-)

Cheers,
Ben.
