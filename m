Return-Path: <ulf.hansson@linaro.org>
Received: from mail-yw0-x232.google.com (mail-yw0-x232.google.com
 [IPv6:2607:f8b0:4002:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6Pvp3pG9zDqb4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 00:43:18 +1000 (AEST)
Received: by mail-yw0-x232.google.com with SMTP id a12so1444571ywh.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 07:43:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170630115331.73869-2-ivan@de.ibm.com>
References: <20170630115331.73869-2-ivan@de.ibm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Jul 2017 16:43:14 +0200
Message-ID: <CAPDyKFop7DyEgDBisBOE0a3Z1PJtHFdQ_Vh8SY9onjLAEDwSTQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc/host: add FSP2(ppc476fpe) into depends for
 sdhci-st
To: Ivan Mikhaylov <ivan@de.ibm.com>
Cc: Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Patrice Chotard <patrice.chotard@st.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel@stlinux.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 30 June 2017 at 13:53, Ivan Mikhaylov <ivan@de.ibm.com> wrote:
> shdci-st driver can be used for ppc476 fsp2 soc.
>
> Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 2eb9701..edf5787 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -354,7 +354,7 @@ config MMC_MOXART
>
>  config MMC_SDHCI_ST
>         tristate "SDHCI support on STMicroelectronics SoC"
> -       depends on ARCH_STI
> +       depends on ARCH_STI || FSP2
>         depends on MMC_SDHCI_PLTFM
>         select MMC_SDHCI_IO_ACCESSORS
>         help
> --
> 1.7.1
>
