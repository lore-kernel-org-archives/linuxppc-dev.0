Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7F62DDDF71
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 09:48:44 +1100 (EST)
Message-ID: <47606538.2090605@freescale.com>
Date: Wed, 12 Dec 2007 16:48:24 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/3] mpc82xx: Embedded Planet EP8248E support
References: <20071211212247.GB3620@loki.buserror.net>
	<20071212154306.dee76c80.sfr@canb.auug.org.au>
In-Reply-To: <20071212154306.dee76c80.sfr@canb.auug.org.au>
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

Stephen Rothwell wrote:
>> +	ep8248e_bcsr = of_iomap(ep8248e_bcsr_node, 0);
> 
> of_node_put(ep8248e_bcsr_node;

No, because we hold on to the node for later use in ep8248e_mdio_probe().

BTW, is there any actual node removal done that justifies dealing with 
refcounts everywhere?

-Scot
