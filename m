Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 88D632C0387
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Mar 2013 03:33:11 +1100 (EST)
Subject: Re: [PATCH][V2] powerpc: remove the PPC_CLOCK dependency
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1362561364-16073-1-git-send-email-Yuantian.Tang@freescale.com>
Date: Thu, 7 Mar 2013 10:32:58 -0600
Message-Id: <BED928B9-2212-413F-8C96-BCDFCE57C76A@kernel.crashing.org>
References: <1362561364-16073-1-git-send-email-Yuantian.Tang@freescale.com>
To: "<Yuantian.Tang@freescale.com>" <Yuantian.Tang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 6, 2013, at 3:16 AM, <Yuantian.Tang@freescale.com> =
<Yuantian.Tang@freescale.com> wrote:

> From: Tang Yuantian <Yuantian.Tang@freescale.com>
>=20
> config FSL_SOC and CPM do not really depend on PPC_CLOCK. So remove =
it.
> PPC_CLOCK also keeps powerpc archtecture from supporting COMMON_CLK.
>=20
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
> v2: correct the title
>=20
> arch/powerpc/Kconfig           |    1 -
> arch/powerpc/platforms/Kconfig |    1 -
> 2 files changed, 0 insertions(+), 2 deletions(-)

Does the Flexcan driver use this?

- k

>=20
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 352f416..383485b 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -655,7 +655,6 @@ config SBUS
> config FSL_SOC
> 	bool
> 	select HAVE_CAN_FLEXCAN if NET && CAN
> -	select PPC_CLOCK
>=20
> config FSL_PCI
>  	bool
> diff --git a/arch/powerpc/platforms/Kconfig =
b/arch/powerpc/platforms/Kconfig
> index e7a896a..aba81cd 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -343,7 +343,6 @@ config FSL_ULI1575
>=20
> config CPM
> 	bool
> -	select PPC_CLOCK
>=20
> config OF_RTC
> 	bool
> --=20
> 1.7.0.4
>=20
