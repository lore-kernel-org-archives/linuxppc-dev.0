Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A69AEDDE3F
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 10:47:32 +1100 (EST)
Message-ID: <478D450A.8060802@freescale.com>
Date: Tue, 15 Jan 2008 17:43:06 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/3] mtd: Factor out OF partition support from the NOR
	driver.
References: <20080114172116.a2e5aa18.sfr@canb.auug.org.au>
In-Reply-To: <20080114172116.a2e5aa18.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
>> +	nr_parts = 0;
>> +	for (pp = node->child; pp; pp = pp->sibling)
> 
> 	for_each_child_of_node(node, pp)

"for_each_child_of_node" is only in Paul's tree, but this has to go via mtd.

Plus, I'm just moving the code; it's not new.

-Scott
