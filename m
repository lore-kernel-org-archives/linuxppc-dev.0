Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C6247DDE39
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 13:37:14 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	lB32b9XR010833
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Dec 2007 19:37:09 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lB32b73X007071
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Dec 2007 20:37:08 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/3] [POWERPC] Add docs for Freescale 83xx SATA device
	tree nodes
Date: Mon, 3 Dec 2007 10:37:04 +0800
Message-ID: <989B956029373F45A0B8AF029708189001B4D1E6@zch01exm26.fsl.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0711202312130.24220@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>
	<Pine.LNX.4.64.0711202312130.24220@blarg.am.freescale.net>
From: "Li Yang" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Wednesday, November 21, 2007 1:13 PM
> To: linuxppc-dev@ozlabs.org
> Cc: Segher Boessenkool; Li Yang
> Subject: [PATCH 1/3] [POWERPC] Add docs for Freescale 83xx=20
> SATA device tree nodes
>=20
> ---
>  Documentation/powerpc/booting-without-of.txt |   23=20
> +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/powerpc/booting-without-of.txt=20
> b/Documentation/powerpc/booting-without-of.txt
> index e9a3cb1..eb14dd5 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -2514,6 +2514,29 @@ platforms are moved over to use the=20
> flattened-device-tree model.
>        Requred properties:
>         - current-speed : Baud rate of uartlite
>=20
> +    * Freescale 8xxx/3.0 Gb/s SATA nodes
> +
> +    SATA nodes are defined to describe on-chip Serial ATA=20
> controllers.
> +    Each SATA port should have its own node.
> +
> +    Required properties:
> +    - compatible        : compatible list, contains 2=20
> entries, first is
> +			 "fsl,sata-CHIP", where CHIP is the processor

Should be "fsl,CHIP-sata"

> +			 (mpc8315, mpc8379, etc.) and the second is
> +			 "fsl,sata-pq2pro"

Why not use "pq2pro-sata" to be consistent with the CHIP version?

> +    - interrupts        : <interrupt mapping for SATA IRQ>
> +    - interrupt-parent  : optional, if needed for interrupt mapping
> +    - reg               : <registers mapping>
> +
> +   Example:
> +
> +	sata@19000 {
> +		compatible =3D "fsl,mpc8315-sata", "fsl,sata-pq2pro;

Quotation mark missing.

- Leo
