Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 72E4B2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2012 00:00:43 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id q73E0drj017736
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Aug 2012 09:00:40 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1278)
Subject: Re: Upstream patch status?? (v3.6-rc1 out)
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <FB9C2F4C-267C-4A33-A64D-D7BFC5A71D1D@freescale.com>
Date: Fri, 3 Aug 2012 09:00:43 -0500
Message-Id: <2D9A1E35-C414-43F2-8153-A7F48BD7BC44@kernel.crashing.org>
References: <FB9C2F4C-267C-4A33-A64D-D7BFC5A71D1D@freescale.com>
To: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry,

This meant for an internal fsl list.

- k

On Aug 3, 2012, at 8:51 AM, Gala Kumar-B11780 wrote:

> Guys,
>=20
> As v3.6-rc1 is now out we really need to get some of these simpler =
patches upstream and accepted NOW.  Please provide status updates if the =
patch is upstream already let me know.
>=20
> [P1025RDB] (some major differences between upstream and internal =
P1025RDB support)
> powerpc/85xx: Add Quicc Engine support for p1025rdb	P1025RDB		=
Zhicheng Fan
> powerpc/dts: Add ucc uart support for p1025rdb	P1025RDB		=
Zhicheng Fan
> powerpc/dts: Add dts for p1025rdb board	P1025RDB		=
Zhicheng Fan
>=20
> [P1022DS] (this is trivial, please take 10m and get this updated and =
submitted)
> powerpc/mpc85xx: p1022ds support the MTD for NOR and NAND flash	=
P1022DS		Jerry Huang
>=20
> [DTS] (Stuart, can you help and close)
> powerpc/e5500: Add power isa properties to comply with ePAPR 1.1	=
EPAPR		Liu Yu
> powerpc/e500mc: Add power isa properties to comply with ePAPR 1.1	=
EPAPR		Liu Yu
> powerpc/e500v2: Add power isa properties to comply with ePAPR 1.1	=
EPAPR		Liu Yu
>=20
> [MSI] (I think upstream, Timur please verify)
> powerpc/fsl: add MSI support for the Freescale hypervisor	KVM/HV		=
Timur Tabi
>=20
> [CORE]
> powerpc/booke: Re-organize debug code	CORE		Kumar Gala
>=20
> [USB] (Again, this is trivial and spend 10m and send upstream)
> usb/fsl: fixed USB wakeup	USB		Zhao Chenhui
>=20
> [LBC]
> mtd: elbc nand: use drvdata to only remove the relevant chip	LBC		=
Scott Wood
>=20
> [SATA]
> libata-pmp: add schedule timeout to support some PMP cards	SATA		=
Jerry Huang
> fsl-sata: workaround to fix the exception of link layer	SATA		=
Qiang Liu
>=20
> - k
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
