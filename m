Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 81143DDE08
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 06:18:49 +1100 (EST)
Message-ID: <49382CFF.2050602@freescale.com>
Date: Thu, 04 Dec 2008 13:18:23 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] powerpc/83xx: Enable FIXED_PHY in mpc834x_itx and mpc83xx
	defconfigs
References: <ed82fe3e0812040915i696e99bep75a37b0e38154415@mail.gmail.com>
	<20081204175231.GA28554@oksana.dev.rtsoft.ru>
In-Reply-To: <20081204175231.GA28554@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> The FIXED_PHY driver isn't enabled in the defconfig. Following
> patch should fix the issue.
> 
>  arch/powerpc/configs/83xx/mpc834x_itx_defconfig |    2 +-
>  arch/powerpc/configs/mpc83xx_defconfig          |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Timur Tabi <timur@freescale.com>

Kumar, please apply.

-- 
Timur Tabi
Linux kernel developer at Freescale
