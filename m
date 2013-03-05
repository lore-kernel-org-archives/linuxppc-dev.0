Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 423562C02AC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 07:31:39 +1100 (EST)
Date: Tue, 5 Mar 2013 14:31:29 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: add missing deo ISA category to e500mc/e5500 dts
To: Stuart Yoder <stuart.yoder@freescale.com>
References: <1362515016-18296-1-git-send-email-stuart.yoder@freescale.com>
In-Reply-To: <1362515016-18296-1-git-send-email-stuart.yoder@freescale.com>
 (from stuart.yoder@freescale.com on Tue Mar  5 14:23:36 2013)
Message-ID: <1362515489.25308.9@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/05/2013 02:23:36 PM, Stuart Yoder wrote:
> From: Stuart Yoder <stuart.yoder@freescale.com>
>=20
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/e500mc_power_isa.dtsi |    1 +
>  arch/powerpc/boot/dts/fsl/e5500_power_isa.dtsi  |    1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/arch/powerpc/boot/dts/fsl/e500mc_power_isa.dtsi =20
> b/arch/powerpc/boot/dts/fsl/e500mc_power_isa.dtsi
> index 870c653..0e7bb68 100644
> --- a/arch/powerpc/boot/dts/fsl/e500mc_power_isa.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/e500mc_power_isa.dtsi
> @@ -53,6 +53,7 @@
>  		power-isa-mmc;		// Memory Coherence
>  		power-isa-scpm;		// Store Conditional Page =20
> Mobility
>  		power-isa-wt;		// Wait
> +		power-isa-deo;		// Data Cache Extended =20
> Operations
>  		mmu-type =3D "power-embedded";
>  	};
>  };
> diff --git a/arch/powerpc/boot/dts/fsl/e5500_power_isa.dtsi =20
> b/arch/powerpc/boot/dts/fsl/e5500_power_isa.dtsi
> index 3230212..39eba29 100644
> --- a/arch/powerpc/boot/dts/fsl/e5500_power_isa.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/e5500_power_isa.dtsi
> @@ -54,6 +54,7 @@
>  		power-isa-scpm;		// Store Conditional Page =20
> Mobility
>  		power-isa-wt;		// Wait
>  		power-isa-64;		// 64-bit
> +		power-isa-deo;		// Data Cache Extended =20
> Operations
>  		mmu-type =3D "power-embedded";
>  	};
>  };

This is an FSL EREF category, not a Power ISA V2.06B category.

-Scott=
