Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B19E67C0A
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 15:44:58 +1000 (EST)
In-Reply-To: <Pine.LNX.4.61.0610191947090.632@ld0175-tx32.am.freescale.net>
References: <Pine.LNX.4.61.0610191947090.632@ld0175-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <94A9DAA6-37CD-48F0-A793-70274E0B38FA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Slight refactor of interrupt mapping for FSL parts (take
	3)
Date: Fri, 20 Oct 2006 00:44:52 -0500
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 19, 2006, at 7:52 PM, Andy Fleming wrote:

> * Cleaned up interrupt mapping a little by adding a helper
>   function which parses the irq out of the device-tree, and puts
>   it into a resource.

Split this patch in two.  One for the mapping cleanup and one for the  
PHY changes.

> * Changed the arch/ppc platform files to specify PHY_POLL, instead  
> of -1

This seems like a confusing way to indicate lack of interrupt.  Can't  
remember but if in my system all the PHYs are just polled do I even  
have to setup the data structure?

> * Changed the fixed phy to use PHY_IGNORE_INTERRUPT
> * Added ethtool.h and mii.h to phy.h includes

- kumar
