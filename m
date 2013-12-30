Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0241.outbound.protection.outlook.com [207.46.163.241])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D50CE2C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Dec 2013 13:39:10 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>, "Chang-Ming.Huang@freescale.com"
 <Chang-Ming.Huang@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>
Subject: RE: [PATCH 1/2] powerpc/p1022ds: fix rtc compatible string
Date: Mon, 30 Dec 2013 02:39:02 +0000
Message-ID: <2aabe7eb4d9c4c66b8d0ce7efccbe6e7@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1387355964-39486-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1387355964-39486-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

Could you apply these patches?

[1/2] powerpc/p1022ds: fix rtc compatible string, http://patchwork.ozlabs.o=
rg/patch/302741/
[2/2] powerpc/p1022ds: add a interrupt for rtc node, http://patchwork.ozlab=
s.org/patch/302742/

-Dongsheng

> -----Original Message-----
> From: Dongsheng Wang [mailto:dongsheng.wang@freescale.com]
> Sent: Wednesday, December 18, 2013 4:39 PM
> To: Wood Scott-B07421; Huang Changming-R66093; Zang Roy-R61911
> Cc: linuxppc-dev@lists.ozlabs.org; Wang Dongsheng-B40534
> Subject: [PATCH 1/2] powerpc/p1022ds: fix rtc compatible string
>=20
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>=20
> RTC Hardware(ds3232) and rtc compatible string does not match.
> Change "dallas,ds1339" to "dallas,ds3232".
>=20
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
>=20
> diff --git a/arch/powerpc/boot/dts/p1022ds.dtsi
> b/arch/powerpc/boot/dts/p1022ds.dtsi
> index 873da35..5725058 100644
> --- a/arch/powerpc/boot/dts/p1022ds.dtsi
> +++ b/arch/powerpc/boot/dts/p1022ds.dtsi
> @@ -146,7 +146,7 @@
>  			 */
>  		};
>  		rtc@68 {
> -			compatible =3D "dallas,ds1339";
> +			compatible =3D "dallas,ds3232";
>  			reg =3D <0x68>;
>  		};
>  		adt7461@4c {
> --
> 1.8.5
>=20
