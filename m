Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D4F51A0AE3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 15:57:45 +1000 (AEST)
Message-ID: <1434607064.25157.2.camel@ellerman.id.au>
Subject: Re: [PATCH] cxl: Fix typo in debug print
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Cc: benh <benh@kernel.crashing.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Ian Munsie <ianmunsi@au1.ibm.com>
Date: Thu, 18 Jun 2015 15:57:44 +1000
In-Reply-To: <1434604510.2942.33.camel@neuling.org>
References: <1434604510.2942.33.camel@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-06-18 at 15:15 +1000, Michael Neuling wrote:
> Fix typo in debug print.  p1->p2.  No functional change.

That's not "no functional change", it changes the behaviour, unless p2_base()
implements the same logic as p1_base()?

cheers

> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 1ef0164..8515791 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -204,7 +204,7 @@ static void dump_cxl_config_space(struct pci_dev *dev)
>  	dev_info(&dev->dev, "p1 regs: %#llx, len: %#llx\n",
>  		p1_base(dev), p1_size(dev));
>  	dev_info(&dev->dev, "p2 regs: %#llx, len: %#llx\n",
> -		p1_base(dev), p2_size(dev));
> +		p2_base(dev), p2_size(dev));
>  	dev_info(&dev->dev, "BAR 4/5: %#llx, len: %#llx\n",
>  		pci_resource_start(dev, 4), pci_resource_len(dev, 4));
>  
> 
> 
