Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 40ED4DE7C5
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 03:44:48 +1100 (EST)
Message-ID: <47E92C02.2070102@freescale.com>
Date: Tue, 25 Mar 2008 11:44:50 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] cpm_uart: Allocate DPRAM memory for SMC ports on
	CPM2-based platforms.
References: <20080325160331.GB15093@ld0162-tx32.am.freescale.net>
	<200803251720.24667.laurentp@cse-semaphore.com>
In-Reply-To: <200803251720.24667.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent Pinchart wrote:
> On Tuesday 25 March 2008 17:03, Scott Wood wrote:
>> Yes, I've answered questions on the lists from at least one person using
>> a custom board with cpm2 smc.
> 
> Are you sure it wasn't me ? ;-)

Yes. :-)

>> Will a CPM reset blow away the portion of muram that holds the SMC pram
>> pointer?  If not (and I don't think it will), just return the device tree
>> reg resource as is currently done if the resource is the wrong size.
> 
> Ok I'll do that. Should I add a warning message to tell people to update the 
> device tree ?

Sure.

-Scott
