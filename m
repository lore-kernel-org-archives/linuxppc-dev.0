Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 922F5DDF1D
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 02:49:49 +1000 (EST)
Subject: Re: [PATCH 1/2] Fix error checking in Vitesse IRQ config
From: Jon Loeliger <jdl@freescale.com>
To: Andy Fleming <afleming@freescale.com>
In-Reply-To: <11847405503115-git-send-email-afleming@freescale.com>
References: <11847405503115-git-send-email-afleming@freescale.com>
Content-Type: text/plain
Message-Id: <1184863782.16820.10.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 19 Jul 2007 11:49:42 -0500
Cc: netdev@vger.kernel.org, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-18 at 01:35, Andy Fleming wrote:
> phy_read() returns a negative number if there's an error, but the
> error-checking code in the Vitesse driver's config_intr function
> triggers if phy_read() returns non-zero.  Correct that.
> 
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> ---
> I made a really stupid mistake in the 4 patches I sent out, earlier.  I
> thought those patches had been tested, but they hadn't been.  This one
> corrects a tiny error in the patch, and they have now been tested.  As before
> this change can be pulled from:
> 
> http://opensource.freescale.com/pub/scm/linux-2.6-85xx.git netdev
> 
> Really, REALLY sorry about that.  I have been given a paper bag of appropriate
> size and shape to fit over my head.
> 
>  drivers/net/phy/vitesse.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
> index 6a53856..8874497 100644


Acked-by: Jon Loeliger <jdl@freescale.com>

Tested on the 8641HPCN.

Thanks,
jdl
