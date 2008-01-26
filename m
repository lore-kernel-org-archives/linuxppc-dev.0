Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9F2A2DDDF4
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jan 2008 02:40:31 +1100 (EST)
Message-Id: <F46728E2-6406-4411-9E24-F12D5DAC2491@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <479AD93D.30202@pikatech.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH]  FIXED_MII_100_FDX
Date: Sat, 26 Jan 2008 09:40:15 -0600
References: <479AD93D.30202@pikatech.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Jeff Garzik <jeff@garzik.org>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 26, 2008, at 12:54 AM, Sean MacLennan wrote:

> On the last git pull,  FIXED_MII_100_FDX was removed from the phy
> Kconfig, but the Kconfig for CPMAC still tried to select it.
>
> Cheers,
>   Sean
>
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
> ---
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 9af05a2..297a4b5 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -1710,7 +1710,6 @@ config CPMAC
> 	depends on NET_ETHERNET && EXPERIMENTAL && AR7
> 	select PHYLIB
> 	select FIXED_PHY
> -	select FIXED_MII_100_FDX
> 	help
> 	  TI AR7 CPMAC Ethernet support

This patch isn't sufficient.  AntonV has posted a proper fix that we  
need Jeff to pick up.

http://ozlabs.org/pipermail/linuxppc-dev/2008-January/050330.html

- k
