Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0AB28DDEB7
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 23:46:49 +1000 (EST)
In-Reply-To: <1192195728-24189-5-git-send-email-leoli@freescale.com>
References: <1192195728-24189-1-git-send-email-leoli@freescale.com>
	<1192195728-24189-2-git-send-email-leoli@freescale.com>
	<1192195728-24189-3-git-send-email-leoli@freescale.com>
	<1192195728-24189-4-git-send-email-leoli@freescale.com>
	<1192195728-24189-5-git-send-email-leoli@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F5AD4702-2832-4408-81DB-0E78B1883D76@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 4/9] add platform support for MPC837x MDS board
Date: Wed, 17 Oct 2007 08:47:21 -0500
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


On Oct 12, 2007, at 8:28 AM, Li Yang wrote:

> The MPC837x MDS is a new member of Freescale MDS reference system.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  arch/powerpc/platforms/83xx/Kconfig       |   12 ++++
>  arch/powerpc/platforms/83xx/Makefile      |    1 +
>  arch/powerpc/platforms/83xx/mpc837x_mds.c |  103 ++++++++++++++++++ 
> +++++++++++
>  3 files changed, 116 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/platforms/83xx/mpc837x_mds.c
>
> diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/ 
> platforms/83xx/Kconfig
> index ec305f1..0c61e7a 100644
> --- a/arch/powerpc/platforms/83xx/Kconfig
> +++ b/arch/powerpc/platforms/83xx/Kconfig
> @@ -50,6 +50,11 @@ config MPC836x_MDS
>  	help
>  	  This option enables support for the MPC836x MDS Processor Board.
>
> +config MPC837x_MDS
> +	bool "Freescale MPC837x MDS"
> +	select DEFAULT_UIMAGE
> +	help
> +	  This option enables support for the MPC837x MDS Processor Board.
>  endchoice
>
>  config PPC_MPC831x
> @@ -75,3 +80,10 @@ config PPC_MPC836x
>  	select PPC_UDBG_16550
>  	select PPC_INDIRECT_PCI
>  	default y if MPC836x_MDS
> +
> +config PPC_MPC837x
> +	bool
> +	select PPC_UDBG_16550
> +	select PPC_INDIRECT_PCI
> +	select FSL_SERDES
> +	default y if MPC837x_MDS

Do we really need this Kconfig option for anything?

- k
