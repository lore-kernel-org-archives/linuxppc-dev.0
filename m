Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD130DDDFE
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 08:33:59 +1100 (EST)
Message-ID: <4751D340.6020204@pobox.com>
Date: Sat, 01 Dec 2007 16:33:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 1/3][RESEND] phylib: add PHY interface modes for internal
	delay for tx and rx only
References: <20071126161748.9671b828.kim.phillips@freescale.com>
In-Reply-To: <20071126161748.9671b828.kim.phillips@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, Li Yang <leoli@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kim Phillips wrote:
> Allow phylib specification of cases where hardware needs to configure
> PHYs for Internal Delay only on either RX or TX (not both).
> 
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> Tested-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Acked-by: Li Yang <leoli@freescale.com>
> ---
>  include/linux/phy.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index f0742b6..e10763d 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -58,6 +58,8 @@ typedef enum {
>  	PHY_INTERFACE_MODE_RMII,
>  	PHY_INTERFACE_MODE_RGMII,
>  	PHY_INTERFACE_MODE_RGMII_ID,
> +	PHY_INTERFACE_MODE_RGMII_RXID,
> +	PHY_INTERFACE_MODE_RGMII_TXID,
>  	PHY_INTERFACE_MODE_RTBI
>  } phy_interface_t;

applied 1-3
