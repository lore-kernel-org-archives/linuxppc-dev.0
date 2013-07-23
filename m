Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 91CC22C008A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 02:19:31 +1000 (EST)
Date: Tue, 23 Jul 2013 11:19:20 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] Powerpc: Add voltage support in dts file
To: Haijun Zhang <Haijun.Zhang@freescale.com>
References: <1374548345-15017-1-git-send-email-Haijun.Zhang@freescale.com>
In-Reply-To: <1374548345-15017-1-git-send-email-Haijun.Zhang@freescale.com>
 (from Haijun.Zhang@freescale.com on Mon Jul 22 21:59:04 2013)
Message-ID: <1374596360.15592.25@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linux-mmc@vger.kernel.org, r39252@freescale.com, AFLEMING@freescale.com,
 cbouatmailru@gmail.com, cjb@laptop.org, linuxppc-dev@lists.ozlabs.org,
 Haijun Zhang <haijun.zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/22/2013 09:59:04 PM, Haijun Zhang wrote:
> eSDHC of T4240 had 1.8v voltage support. Add this node to specify
> eSDHC voltage capacity. If this node not specified eSDHC driver
> still can read from eSDHC host capacity register.
>=20
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
> ---
> changes for this patch set:
> 	- split from patch [PATCH 1/2] Powerpc: Add
> 	- voltage ranges support for T4
>=20
>  Documentation/devicetree/bindings/mmc/fsl-esdhc.txt | 3 +++
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi         | 1 +
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt =20
> b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> index bd9be0b..f1ac253 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> @@ -19,6 +19,8 @@ Optional properties:
>      "bus-width =3D <1>" property.
>    - sdhci,auto-cmd12: specifies that a controller can only handle =20
> auto
>      CMD12.
> +  - 3300 3300: specifies that eSDHC controller can support voltages =20
> ranges
> +    from 3300 to 3300.

"3300 3300" is not a property name -- and the voltage-ranges property =20
should be defined more generically, as is done for mmc-spi-slot.txt.

-Scott=
