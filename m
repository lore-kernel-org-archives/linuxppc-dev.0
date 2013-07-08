Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1B1D72C02CB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2013 03:14:20 +1000 (EST)
Date: Mon, 8 Jul 2013 12:14:05 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Powerpc/t4240: change the compatible flags for t4240qds
 board
To: Haijun Zhang <Haijun.Zhang@freescale.com>
References: <1373267764-6364-1-git-send-email-Haijun.Zhang@freescale.com>
In-Reply-To: <1373267764-6364-1-git-send-email-Haijun.Zhang@freescale.com>
 (from Haijun.Zhang@freescale.com on Mon Jul  8 02:16:03 2013)
Message-ID: <1373303645.8183.163@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linux-mmc@vger.kernel.org, r39252@freescale.com, AFLEMING@freescale.com,
 cbouatmailru@gmail.com, cjb@laptop.org, linuxppc-dev@lists.ozlabs.org,
 Haijun Zhang <Haijun.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/08/2013 02:16:03 AM, Haijun Zhang wrote:
> In order to make a difference between different T4240 board.
> Specify T4240QDS board the unique compatible flags for t4240qds
> eSDHC host.
>=20
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi =20
> b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> index bd611a9..08b47d0 100644
> --- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> @@ -397,7 +397,7 @@
>=20
>  /include/ "qoriq-esdhc-0.dtsi"
>  	sdhc@114000 {
> -		compatible =3D "fsl,t4240-esdhc", "fsl,esdhc";
> +		compatible =3D "fsl,t4240qds-esdhc", "fsl,esdhc";
>  		sdhci,auto-cmd12;
>  	};

NACK.  This node is describing the sdhc block of the t4240 SoC.  What =20
board you stick it in doesn't change what it is.

Plus, what about users with old device trees?

-Scott=
