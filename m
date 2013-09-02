Return-Path: <B36685@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B99532C008E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Sep 2013 19:56:12 +1000 (EST)
From: Liu Shengzhou-B36685 <B36685@freescale.com>
To: Xie Xiaobo-R63061 <r63061@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "galak@kernel.crashing.org"
 <galak@kernel.crashing.org>, Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH V2 2/2] powerpc/85xx: Add TWR-P1025 board support
Date: Mon, 2 Sep 2013 09:55:40 +0000
Message-ID: <3F453DDFF675A64A89321A1F35281021A9AC06@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1377856896-29244-1-git-send-email-X.Xie@freescale.com>
 <1377856896-29244-2-git-send-email-X.Xie@freescale.com>
In-Reply-To: <1377856896-29244-2-git-send-email-X.Xie@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Johnston Michael-R49610 <r49610@freescale.com>,
 Xie Xiaobo-R63061 <r63061@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+shengzhou.liu=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Xie =
Xiaobo
> Sent: Friday, August 30, 2013 6:02 PM
> To: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Wood Scott-=
B07421
> Cc: Johnston Michael-R49610; Xie Xiaobo-R63061
> Subject: [PATCH V2 2/2] powerpc/85xx: Add TWR-P1025 board support
>=20
> +
> +	mdio@24000 {
> +		phy0: ethernet-phy@2 {
> +			interrupt-parent =3D <&mpic>;
> +			interrupts =3D <1 1>;
> +			reg =3D <0x2>;
> +		};
> +
> +		phy1: ethernet-phy@1 {
> +			interrupt-parent =3D <&mpic>;
> +			interrupts =3D <2 1>;
> +			reg =3D <0x1>;
> +		};

#interrupt-cells is 4.
