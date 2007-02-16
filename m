Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6671EDDD06
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 14:37:38 +1100 (EST)
In-Reply-To: <Pine.LNX.4.61.0702152046450.9034@ld0175-tx32.am.freescale.net>
References: <Pine.LNX.4.61.0702152046450.9034@ld0175-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <67F943D0-C86B-4324-A093-A3CAC9C6CAFF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC 7/7] Unite all PCI-e on 85xx and 86xx under one codebase
Date: Thu, 15 Feb 2007 21:36:43 -0600
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 15, 2007, at 8:50 PM, Andy Fleming wrote:

> Skip the fake PCI bridge (FPGA)
>
> modified: arch/powerpc/platforms/85xx/mpc85xx_cds.c
> Deleted the exclude list. Implemented by class/PIR
>
> modified: arch/powerpc/platforms/85xx/pci.c
> PEX should not set primary since PCI1 sets already
>
> modified: drivers/pci/probe.c
> Changed child resources assignment when bridge is transparent
> Identifid powerpc processor by class and fixed resources
> Removed whitespace
> Signed-off-by: York Sun <yorksun@freescale.com>
> Acked-by: Andy Fleming <afleming@freescale.com>

This patch should really be broken into its parts.  There are changes  
to the generic PCI code but I can't really tell what they are trying  
to accomplish or why they are needed.

- k
