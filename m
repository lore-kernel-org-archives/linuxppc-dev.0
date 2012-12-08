Return-Path: <B16394@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 82E122C0100
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2012 15:30:11 +1100 (EST)
From: Garg Vakul-B16394 <B16394@freescale.com>
To: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
Subject: RE: [PATCH] Revert "crypto: caam - Updated SEC-4.0 device tree
 binding for ERA information."
Date: Sat, 8 Dec 2012 04:30:03 +0000
Message-ID: <065BBB7616BCE543832A2EF096986B9413FB3F@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1354870649-3656-1-git-send-email-vakul@freescale.com>
In-Reply-To: <1354870649-3656-1-git-send-email-vakul@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kindly ignore this.
I would send another patch updating device tree binding directly with the n=
ew proposed property.

> -----Original Message-----
> From: devicetree-discuss [mailto:devicetree-discuss-
> bounces+vakul=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Vakul Garg
> Sent: Friday, December 07, 2012 2:27 PM
> To: linux-crypto@vger.kernel.org; linuxppc-dev@ozlabs.org; devicetree-
> discuss@lists.ozlabs.org
> Subject: [PATCH] Revert "crypto: caam - Updated SEC-4.0 device tree
> binding for ERA information."
>=20
> This reverts commit a2c0911c09190125f52c9941b9d187f601c2f7be.
>=20
> Signed-off-by: Vakul Garg <vakul@freescale.com>
> ---
> Instead of adding SEC era information in crypto node's compatible, a new
> property 'fsl,sec-era' is being introduced into crypto node.
>=20
>  .../devicetree/bindings/crypto/fsl-sec4.txt        |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> index fc9ce6f..bd7ce12 100644
> --- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> +++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> @@ -54,8 +54,7 @@ PROPERTIES
>     - compatible
>        Usage: required
>        Value type: <string>
> -      Definition: Must include "fsl,sec-v4.0". Also includes SEC
> -           ERA versions (optional) with which the device is compatible.
> +      Definition: Must include "fsl,sec-v4.0"
>=20
>     - #address-cells
>         Usage: required
> @@ -107,7 +106,7 @@ PROPERTIES
>=20
>  EXAMPLE
>  	crypto@300000 {
> -		compatible =3D "fsl,sec-v4.0", "fsl,sec-era-v2.0";
> +		compatible =3D "fsl,sec-v4.0";
>  		#address-cells =3D <1>;
>  		#size-cells =3D <1>;
>  		reg =3D <0x300000 0x10000>;
> --
> 1.7.7.6
>=20
>=20
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
