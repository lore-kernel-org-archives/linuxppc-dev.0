Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 10346DDE41
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 16:26:09 +1100 (EST)
Date: Wed, 7 Mar 2007 23:22:56 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Move 8641 PCI-Express to arch/powerpc/sysdev/fsl_pcie.c.
In-Reply-To: <1173300525.23776.136.camel@ld0161-tx32>
Message-ID: <Pine.LNX.4.64.0703072322380.2619@localhost.localdomain>
References: <1173300525.23776.136.camel@ld0161-tx32>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 7 Mar 2007, Jon Loeliger wrote:

>
> This move sets the stage for the use of generic PCI Express
> code in 85xx and 86xx parts from FSL.  Subsequent patches
> for 8548 and 8544 will be able to use this shared code.
>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> Acked-by: Andy Fleming <afleming@freescale.com>

applied

- k
