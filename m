Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3BB46DDFAF
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 03:10:54 +1000 (EST)
Message-ID: <47026919.4060302@freescale.com>
Date: Tue, 02 Oct 2007 10:51:53 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] cpm: Describe multi-user ram in its own device node.
References: <20070928190616.GB20213@loki.buserror.net>
	<20070929003005.59afc2a0@kernel.crashing.org>
	<08C0C9CB-C958-4B95-81B8-D0677CBA4399@kernel.crashing.org>
	<20070929104917.1585737e@kernel.crashing.org>
	<1B684498-FC47-4F01-A72E-DD27B259613A@kernel.crashing.org>
	<47011BED.8020206@freescale.com>
	<AD243886-65DE-4285-ADD3-1D4C5ABA2E3C@kernel.crashing.org>
	<47025A72.10404@freescale.com> <47026884.4040909@freescale.com>
	<470268F1.9000504@freescale.com>
In-Reply-To: <470268F1.9000504@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Scott Wood wrote:
> 
>> I was thinking of just removing the muram code from qe_lib, and having 
>> it use the code in cpm_common.c.
> 
> Do we want to have the QE library include CPM code at this point?  I 
> know we want to merge some QE and CPM code, but I would rather do that 
> in one shot than piecemeal.

I think piecemeal would be much more manageable.

-Scott
