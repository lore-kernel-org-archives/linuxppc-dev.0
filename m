Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7EFE8DDE9F
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 23:10:22 +1100 (EST)
Date: Thu, 18 Jan 2007 21:10:06 +0900 (JST)
Message-Id: <200701181210.l0ICA69c008115@toshiba.co.jp>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 13/19] powerpc: Supporting iommu for Celleb
In-Reply-To: <1169080280.4965.21.camel@localhost.localdomain>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben-san,

Thank you for your comment.

> > +static int __init celleb_init_iommu(void)
> > +{
> 
> This needs a:
> 
>	if (!machine_is(celleb))
>	   return 0;
> 
> Since the initcall will always be called wether your platform was
> selected at boot or not as long as it's built into the kernel.

We will fix it.

Best regards,
Kou Ishizaki
