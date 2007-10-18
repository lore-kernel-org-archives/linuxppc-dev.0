Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD965DDF8C
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 01:00:22 +1000 (EST)
In-Reply-To: <1192719847-25045-3-git-send-email-leoli@freescale.com>
References: <1192719847-25045-1-git-send-email-leoli@freescale.com>
	<1192719847-25045-2-git-send-email-leoli@freescale.com>
	<1192719847-25045-3-git-send-email-leoli@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BE1276BE-7D5D-4535-B6F7-66E4B5F29FDD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v6 3/9] add Freescale SerDes PHY support
Date: Thu, 18 Oct 2007 10:00:51 -0500
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 18, 2007, at 10:04 AM, Li Yang wrote:

> The SerDes(serializer/deserializer) PHY block is a new SoC block used
> in Freescale chips to support multiple serial interfaces, such as PCI
> Express, SGMII, SATA.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  arch/powerpc/platforms/Kconfig   |    3 +
>  arch/powerpc/sysdev/Makefile     |    1 +
>  arch/powerpc/sysdev/fsl_serdes.c |  195 +++++++++++++++++++++++++++ 
> +++++++++++
>  3 files changed, 199 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/sysdev/fsl_serdes.c
>
> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/ 
> platforms/Kconfig
> index 229d355..0719e89 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -315,6 +315,9 @@ config FSL_ULI1575
>  config CPM
>  	bool
>
> +config FSL_SERDES
> +	bool
> +

do you mind adding help here just something similar to the commit  
comment.  While a user might not see it, its useful documentation  
about what this is all about.

- k
