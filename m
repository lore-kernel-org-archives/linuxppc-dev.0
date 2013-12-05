Return-Path: <scottwood@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 58BB02C0098
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Dec 2013 10:18:52 +1100 (EST)
Received: from mail227-ch1 (localhost [127.0.0.1])	by
 mail227-ch1-R.bigfish.com (Postfix) with ESMTP id E631D5000F2	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 23:18:45 +0000 (UTC)
Received: from CH1EHSMHS001.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.238])	by mail227-ch1.bigfish.com (Postfix) with ESMTP id
 C29B61C80047	for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 23:18:43
 +0000 (UTC)
Message-ID: <1386285513.7375.71.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/defconfig: Enable ath9k wireless card support
From: Scott Wood <scottwood@freescale.com>
To: Chunhe Lan <Chunhe.Lan@freescale.com>
Date: Thu, 5 Dec 2013 17:18:33 -0600
In-Reply-To: <1386055940-20629-1-git-send-email-Chunhe.Lan@freescale.com>
References: <1386055940-20629-1-git-send-email-Chunhe.Lan@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-12-03 at 15:32 +0800, Chunhe Lan wrote:
> On the P1023RDB, when board leaves the factory, it has
> two Atheros wireless cards on the PCIe slot. So enable
> ath9k wireless driver support.
> 
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> Cc: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/configs/85xx/p1023_defconfig |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/configs/85xx/p1023_defconfig b/arch/powerpc/configs/85xx/p1023_defconfig
> index b06d37d..a3fe941 100644
> --- a/arch/powerpc/configs/85xx/p1023_defconfig
> +++ b/arch/powerpc/configs/85xx/p1023_defconfig
> @@ -62,6 +62,9 @@ CONFIG_INET_ESP=y
>  # CONFIG_INET_LRO is not set
>  CONFIG_IPV6=y
>  CONFIG_IP_SCTP=m
> +CONFIG_CFG80211=y
> +CONFIG_CFG80211_WEXT=y
> +CONFIG_MAC80211=y
>  CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
> @@ -101,6 +104,8 @@ CONFIG_DAVICOM_PHY=y
>  CONFIG_CICADA_PHY=y
>  CONFIG_VITESSE_PHY=y
>  CONFIG_FIXED_PHY=y
> +CONFIG_ATH_CARDS=y
> +CONFIG_ATH9K=y
>  CONFIG_INPUT_FF_MEMLESS=m
>  # CONFIG_INPUT_MOUSEDEV is not set
>  # CONFIG_INPUT_KEYBOARD is not set

I thought we decided the p1023 defconfig was going away (to possibly
return if/when datapath is upstreamed and is deemed too large for the
main config)?

-Scott
