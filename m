Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0235.outbound.protection.outlook.com [207.46.163.235])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6BE46140084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 07:02:24 +1000 (EST)
Message-ID: <1398286933.7841.49.camel@snotra.buserror.net>
Subject: Re: [PATCH] net/phy:  tune get_phy_c45_ids to support more c45 phy
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Wed, 23 Apr 2014 16:02:13 -0500
In-Reply-To: <1398246951-27303-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1398246951-27303-1-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: trini@ti.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-04-23 at 17:55 +0800, Shengzhou Liu wrote:
> As some C45 10G PHYs(e.g. Cortina CS4315/CS4340 PHY) have
> zero Devices In package, current driver can't get correct
> devices_in_package value by non-zero Devices In package.
> so let's probe more with zero Devices In package to support
> more C45 PHYs which have zero Devices In package.
> 
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
> Tested with CS4315 on T2080RDB, this patch have no impact on previous XAUI phy with verification. 
> 
>  drivers/net/phy/phy_device.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index cfb5110..8fd777e 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

You need to send this to the netdev list and maintainer.

-Scott
