Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0C48EDDE0E
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 13:34:33 +1000 (EST)
Subject: Re: [PATCH] powerpc: Fix problems with 32bit PPC's running with
	more than 2GB of RAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <becky.bruce@freescale.com>
In-Reply-To: <E87ABEE7-3CD0-45E5-9806-BE3BAAFCFE1C@freescale.com>
References: <1215611076-13518-1-git-send-email-sr@denx.de>
	<1215633758.8970.372.camel@pasglop>
	<20080709162219.4c07a67e@zod.rchland.ibm.com>
	<1215635979.8970.385.camel@pasglop>
	<20080709204435.4214f277@zod.rchland.ibm.com>
	<E87ABEE7-3CD0-45E5-9806-BE3BAAFCFE1C@freescale.com>
Content-Type: text/plain
Date: Sat, 12 Jul 2008 13:33:54 +1000
Message-Id: <1215833634.7549.143.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Are you *sure* you can see all 4GB?  I thought we lost some of the 32- 
> bit PCI address space for PCI IO......  Disclaimer: I'm no expert on  
> PCI :)

You are right. I didn't think that through when I replied. We do lose
some of it for MMIO (not IO). So we cannot really go all the way to 4G
because we can't DMA to all of it, right.

> FYI, I'm *very* close to having swiotlb fully functional on powerpc to  
> support larger RAM - I am able to boot with 6GB on 8641 right now.   
> There are some bugs that I'm still shaking out - I hope to push this  
> out in the next couple of weeks.

That won't make .27 then ?

Cheers,
Ben.
