Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 132A3DDDFB
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 03:06:38 +1100 (EST)
Message-Id: <4A9328DB-F68C-4C09-B762-44FEA85DD12E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080205164425.b6af5bff.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 5/6] Add OF-tree support to RapidIO controller driver.
Date: Tue, 5 Feb 2008 10:06:04 -0600
References: <1201689053956-git-send-email-wei.zhang@freescale.com>
	<12016890621727-git-send-email-wei.zhang@freescale.com>
	<120168907160-git-send-email-wei.zhang@freescale.com>
	<12016890773706-git-send-email-wei.zhang@freescale.com>
	<12016890832943-git-send-email-wei.zhang@freescale.com>
	<20080205164425.b6af5bff.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 4, 2008, at 11:44 PM, Stephen Rothwell wrote:

>>
>> +	aw = *(u32 *)of_get_property(dev->node, "#address-cells", NULL);
>> +	sw = *(u32 *)of_get_property(dev->node, "#size-cells", NULL);
>
> What happens if either of these properties is missing?

Should we add __must_check to of_get_property?

- k
