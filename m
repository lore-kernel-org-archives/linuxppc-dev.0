Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C6318DDFD2
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 14:54:39 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3M4sXlb012991
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 21:54:33 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n3M4sW3E003497
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 23:54:32 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH v3] powerpc/85xx: Add P2020DS board support
Date: Wed, 22 Apr 2009 12:54:31 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208928C445@zch01exm21.fsl.freescale.net>
In-Reply-To: <1240371105-18400-1-git-send-email-galak@kernel.crashing.org>
References: <1240371105-18400-1-git-send-email-galak@kernel.crashing.org>
From: "Liu Dave-R63238" <DaveLiu@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +		L2: l2-cache-controller@20000 {
> +			compatible =3D "fsl,p2020-l2-cache-controller";
> +			reg =3D <0x20000 0x1000>;
> +			cache-line-size =3D <32>;	// 32 bytes
> +			cache-size =3D <0x100000>; // L2, 1M
> +			interrupt-parent =3D <&mpic>;
> +			interrupts =3D <16 2>;
> +		};

One nit --here should be 512KB L2 cache

> +		usb@22000 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			compatible =3D "fsl-usb2-mph";
> +			reg =3D <0x22000 0x1000>;
> +			interrupt-parent =3D <&mpic>;
> +			interrupts =3D <28 0x2>;
> +			phy_type =3D "ulpi";
> +		};

It should be "fsl-usb2-dr"
