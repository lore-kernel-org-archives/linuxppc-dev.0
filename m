Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 7F342DDF23
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 02:42:04 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l2KFg0iG017762
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 08:42:00 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2KFfxg4026344
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 10:42:00 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/2] Add initial MPC8544DS platform files.
Date: Tue, 20 Mar 2007 08:41:58 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302B53612@az33exm25.fsl.freescale.net>
In-Reply-To: <1174346834.6595.365.camel@ld0161-tx32>
References: <1174346834.6595.365.camel@ld0161-tx32>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Loeliger Jon-LOELIGER" <jdl@freescale.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +		mpic: pic@40000 {
> +			clock-frequency =3D <0>;
> +			interrupt-controller;
> +			#address-cells =3D <0>;
> +			#interrupt-cells =3D <2>;
> +			reg =3D <40000 40000>;
> +			built-in;
> +			compatible =3D "chrp,open-pic";
> +			device_type =3D "open-pic";
> +			big-endian;
> +			interrupt-parent =3D <&mpic>;
> +		};

The pic should not have an interrupt-parent property
pointing to itself.

Stuart
