Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 311F6DDF91
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 03:11:20 +1000 (EST)
In-Reply-To: <470268F1.9000504@freescale.com>
References: <20070928190616.GB20213@loki.buserror.net>
	<20070929003005.59afc2a0@kernel.crashing.org>
	<08C0C9CB-C958-4B95-81B8-D0677CBA4399@kernel.crashing.org>
	<20070929104917.1585737e@kernel.crashing.org>
	<1B684498-FC47-4F01-A72E-DD27B259613A@kernel.crashing.org>
	<47011BED.8020206@freescale.com>
	<AD243886-65DE-4285-ADD3-1D4C5ABA2E3C@kernel.crashing.org>
	<47025A72.10404@freescale.com> <47026884.4040909@freescale.com>
	<470268F1.9000504@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E12E3252-E394-4C86-87B7-8E07100A15B4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] cpm: Describe multi-user ram in its own device node.
Date: Tue, 2 Oct 2007 12:11:16 -0500
To: Timur Tabi <timur@freescale.com>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 2, 2007, at 10:51 AM, Timur Tabi wrote:

> Scott Wood wrote:
>
>> I was thinking of just removing the muram code from qe_lib, and  
>> having it use the code in cpm_common.c.
>
> Do we want to have the QE library include CPM code at this point?   
> I know we want to merge some QE and CPM code, but I would rather do  
> that in one shot than piecemeal.

I think piecemeal/iterative is fine.

>> BTW, searching the entire device tree for a node with the name  
>> "data-only", regardless of context, seems a bit insane to me.
>
> Yes, I noticed that, too.

- k
