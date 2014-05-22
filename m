Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0186.outbound.protection.outlook.com [207.46.163.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6FF391A054B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 08:51:57 +1000 (EST)
Date: Thu, 22 May 2014 17:51:45 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: Re: [2/2] powerpc/corenet64_smp_defconfig: enable RTC support
Message-ID: <20140522225144.GA1670@home.buserror.net>
References: <1400666751-11459-2-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1400666751-11459-2-git-send-email-Shengzhou.Liu@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 21, 2014 at 06:05:51PM +0800, Shengzhou Liu wrote:
> Enable RTC support for DS1307, DS1374, DS3232, which is
> needed on some corenet boards.
> 
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> 
> ---
> arch/powerpc/configs/corenet64_smp_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
> index 63508dd..e9c9f86 100644
> --- a/arch/powerpc/configs/corenet64_smp_defconfig
> +++ b/arch/powerpc/configs/corenet64_smp_defconfig
> @@ -125,6 +125,11 @@ CONFIG_USB_EHCI_FSL=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_MMC=y
>  CONFIG_MMC_SDHCI=y
> +CONFIG_RTC_CLASS=y
> +CONFIG_RTC_DRV_CMOS=y
> +CONFIG_RTC_DRV_DS1307=y
> +CONFIG_RTC_DRV_DS1374=y
> +CONFIG_RTC_DRV_DS3232=y
>  CONFIG_EDAC=y
>  CONFIG_EDAC_MM_EDAC=y
>  CONFIG_DMADEVICES=y

Why only corenet64 and not corenet32?

-Scott
