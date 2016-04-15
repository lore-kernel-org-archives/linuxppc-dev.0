Return-Path: <leoyang.li@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0078.outbound.protection.outlook.com [157.56.112.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmkpW57jZzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Apr 2016 03:21:06 +1000 (AEST)
From: Yang-Leo Li <leoyang.li@nxp.com>
To: Chenhui Zhao <chenhui.zhao@nxp.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "oss@buserror.net" <oss@buserror.net>
CC: Chenhui Zhao <chenhui.zhao@nxp.com>, Zhengxiong Jin <jason.jin@nxp.com>
Subject: RE: [PATCH v2 3/5] powerpc/dts: add a compatible	string to gpio0
Date: Fri, 15 Apr 2016 16:47:29 +0000
Message-ID: <AM2PR04MB07707AC7D99349C2A636CC938F680@AM2PR04MB0770.eurprd04.prod.outlook.com>
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



> -----Original Message-----
> From: linuxppc-release-bounces@linux.freescale.net [mailto:linuxppc-relea=
se-
> bounces@linux.freescale.net] On Behalf Of Chenhui Zhao
> Sent: Friday, April 15, 2016 6:13 AM
> To: linuxppc-dev@lists.ozlabs.org; oss@buserror.net
> Cc: Chenhui Zhao <chenhui.zhao@nxp.com>; Zhengxiong Jin
> <jason.jin@nxp.com>
> Subject: [linuxppc-release] [PATCH v2 3/5] powerpc/dts: add a compatible =
string
> to gpio0
>=20
> All gpio nodes used the same compatible string "fsl,qoriq-gpio".
> To identify the node corresponding to the GPIO1 pins, add a compatible st=
ring
> "fsl,qoriq-gpio-1".

This is not a documented binding.  And we normally don't add compatible str=
ings for this purpose.  If you want to reference a specific GPIO pin, use t=
he binding described at Documentation/devicetree/bindings/gpio/gpio.txt

Regards,
Leo

>=20
> Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
> ---
>  arch/powerpc/boot/dts/fsl/qoriq-gpio-0.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/boot/dts/fsl/qoriq-gpio-0.dtsi
> b/arch/powerpc/boot/dts/fsl/qoriq-gpio-0.dtsi
> index cf714f5..1a26d6b 100644
> --- a/arch/powerpc/boot/dts/fsl/qoriq-gpio-0.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/qoriq-gpio-0.dtsi
> @@ -33,7 +33,7 @@
>   */
>=20
>  gpio0: gpio@130000 {
> -	compatible =3D "fsl,qoriq-gpio";
> +	compatible =3D "fsl,qoriq-gpio-1", "fsl,qoriq-gpio";
>  	reg =3D <0x130000 0x1000>;
>  	interrupts =3D <55 2 0 0>;
>  	#gpio-cells =3D <2>;
> --
> 1.9.1
>=20
> _______________________________________________
> linuxppc-release mailing list
> linuxppc-release@linux.freescale.net
> http://linux.freescale.net/mailman/listinfo/linuxppc-release
