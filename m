Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 061B5DE305
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 05:37:11 +1000 (EST)
Message-ID: <482204DF.9070600@freescale.com>
Date: Wed, 07 May 2008 14:37:03 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH v2] powerpc: Fix a bunch of sparse warnings in the qe_lib
References: <1210184384-28425-1-git-send-email-afleming@freescale.com>
In-Reply-To: <1210184384-28425-1-git-send-email-afleming@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andy Fleming wrote:
> Mostly having to do with not marking things __iomem.  And some failure
> to use appropriate accessors to read MMIO regs.
> 
> Signed-off-by: Andy Fleming <afleming@freescale.com>

Acked-By: Timur Tabi <timur@freescale.com>

(Not timur.tabi@freescale.com)

-- 
Timur Tabi
Linux kernel developer at Freescale
