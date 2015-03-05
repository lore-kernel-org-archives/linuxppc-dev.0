Return-Path: <ulf.hansson@linaro.org>
Received: from mail-qc0-f181.google.com (mail-qc0-f181.google.com
 [209.85.216.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B4001A01DC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 00:50:17 +1100 (AEDT)
Received: by qcxr5 with SMTP id r5so43039632qcx.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2015 05:50:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1424952503-8247-10-git-send-email-haokexin@gmail.com>
References: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
 <1424952503-8247-10-git-send-email-haokexin@gmail.com>
Date: Thu, 5 Mar 2015 14:50:15 +0100
Message-ID: <CAPDyKFpRcoXOvnvoiDx72nVsvrADODDCncdAz=YP19kRM99Ucw@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] mmc: kconfig: replace PPC_OF with PPC
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Kevin Hao <haokexin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Chris Ball <chris@printf.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26 February 2015 at 13:08, Kevin Hao <haokexin@gmail.com> wrote:
> The PPC_OF is a ppc specific option which is used to mean that the
> firmware device tree access functions are available. Since all the
> ppc platforms have a device tree, it is aways set to 'y' for ppc.
> So it makes no sense to keep a such option in the current kernel.
> Replace it with PPC.
>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Applied, thanks!

Kind regards
Uffe


> ---
> v2: No change.
>
>  drivers/mmc/host/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 61ac63a3776a..7858d7a52818 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -132,7 +132,7 @@ config MMC_SDHCI_OF_ARASAN
>  config MMC_SDHCI_OF_ESDHC
>         tristate "SDHCI OF support for the Freescale eSDHC controller"
>         depends on MMC_SDHCI_PLTFM
> -       depends on PPC_OF
> +       depends on PPC
>         select MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
>         help
>           This selects the Freescale eSDHC controller support.
> @@ -144,7 +144,7 @@ config MMC_SDHCI_OF_ESDHC
>  config MMC_SDHCI_OF_HLWD
>         tristate "SDHCI OF support for the Nintendo Wii SDHCI controllers"
>         depends on MMC_SDHCI_PLTFM
> -       depends on PPC_OF
> +       depends on PPC
>         select MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
> --
> 1.9.3
>
