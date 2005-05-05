Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 74A6C67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 May 2005 23:31:53 +1000 (EST)
In-Reply-To: <1115297124.9050.12.camel@jmcmullan.timesys>
References: <1115297124.9050.12.camel@jmcmullan.timesys>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <736378e38e2e5b0b7266f5c075e20ac1@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 5 May 2005 09:31:41 -0400
To: Jason McMullan <jason.mcmullan@timesys.com>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 2.6.11.7 MPC8xx Swap Band-Aid
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 5, 2005, at 8:45 AM, Jason McMullan wrote:

> First off, this patch works.

Well ..... if you invalidate TLBs and flush cache often enough,
you can mask lots of problems :-)


> Secondly, I don't know exactly why. I just found all the band-aids I
> could for MPC8xx swap functionality, applied them, and fixed the places
> where it still bled.

We shouldn't have the 8xx as a special case for the swap flags and
information.  We need to take a closer look at this.  I guess I'll do 
that
as part of fixing up the PTEs for the BDI2000 as well.

> It's more of a dancing bear, than a real fix, but I now have working
> swap (using ATA over Ethernet) on my MPC885 ADS.

IIRC, ATA over Ethernet isn't the same as disk doing DMA due to the
data copies involved.

Thanks.

	-- Dan
