Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87A8CDDDF8
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 23:09:29 +1000 (EST)
In-Reply-To: <20070717004936.21700.67900.stgit@localhost.localdomain>
References: <20070717004936.21700.67900.stgit@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0DE0F202-0D89-4CC2-A67D-CB7D40EFB7DB@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] POWERPC: add support of the GiGE switch for mpc8313RDB
	via fixed PHY
Date: Tue, 17 Jul 2007 15:09:19 +0200
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This utilises pretend phy, making access to it via device tree.  
> GiGE switch
> is connected to TSEC1 with fixed gigE link, so we need to emulate it
> via artificial PHY to make it work.

Even if "pretend phy" in the device tree would be a good
idea (and it's not)...

>  			#size-cells = <0>;
>  			phy1: ethernet-phy@1 {
>  				interrupt-parent = < &ipic >;
> +				compatible = "fixed";

...you cannot seriously believe you are allowed to claim
the name "fixed" for it.

NAK.


Segher
