Return-Path: <B11780@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3CDA62C0095
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2012 23:51:56 +1000 (EST)
Received: from mail50-tx2 (localhost [127.0.0.1])	by mail50-tx2-R.bigfish.com
 (Postfix) with ESMTP id 230EF2E0187	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Aug 2012 13:51:52 +0000 (UTC)
Received: from TX2EHSMHS037.bigfish.com (unknown [10.9.14.254])	by
 mail50-tx2.bigfish.com (Postfix) with ESMTP id 8FF9D4C025A	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2012 13:51:50 +0000 (UTC)
From: Gala Kumar-B11780 <B11780@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Tabi Timur-B04825
 <B04825@freescale.com>, Liu Yu-B13201 <B13201@freescale.com>, Fan
 Zhicheng-B32736 <B32736@freescale.com>, Huang Changming-R66093
 <r66093@freescale.com>, Liu Qiang-B32616 <B32616@freescale.com>, Zhao
 Chenhui-B35336 <B35336@freescale.com>, Yoder Stuart-B08248
 <B08248@freescale.com>, Kushwaha Prabhakar-B32579 <B32579@freescale.com>
Subject: Upstream patch status?? (v3.6-rc1 out)
Date: Fri, 3 Aug 2012 13:51:49 +0000
Message-ID: <FB9C2F4C-267C-4A33-A64D-D7BFC5A71D1D@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Trefny Thomas-RAT188 <RAT188@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Guys,

As v3.6-rc1 is now out we really need to get some of these simpler patches =
upstream and accepted NOW.  Please provide status updates if the patch is u=
pstream already let me know.

[P1025RDB] (some major differences between upstream and internal P1025RDB s=
upport)
powerpc/85xx: Add Quicc Engine support for p1025rdb	P1025RDB		Zhicheng Fan
powerpc/dts: Add ucc uart support for p1025rdb	P1025RDB		Zhicheng Fan
powerpc/dts: Add dts for p1025rdb board	P1025RDB		Zhicheng Fan

[P1022DS] (this is trivial, please take 10m and get this updated and submit=
ted)
powerpc/mpc85xx: p1022ds support the MTD for NOR and NAND flash	P1022DS		Je=
rry Huang

[DTS] (Stuart, can you help and close)
powerpc/e5500: Add power isa properties to comply with ePAPR 1.1	EPAPR		Liu=
 Yu
powerpc/e500mc: Add power isa properties to comply with ePAPR 1.1	EPAPR		Li=
u Yu
powerpc/e500v2: Add power isa properties to comply with ePAPR 1.1	EPAPR		Li=
u Yu

[MSI] (I think upstream, Timur please verify)
powerpc/fsl: add MSI support for the Freescale hypervisor	KVM/HV		Timur Tab=
i

[CORE]
powerpc/booke: Re-organize debug code	CORE		Kumar Gala

[USB] (Again, this is trivial and spend 10m and send upstream)
usb/fsl: fixed USB wakeup	USB		Zhao Chenhui

[LBC]
mtd: elbc nand: use drvdata to only remove the relevant chip	LBC		Scott Woo=
d

[SATA]
libata-pmp: add schedule timeout to support some PMP cards	SATA		Jerry Huan=
g
fsl-sata: workaround to fix the exception of link layer	SATA		Qiang Liu

- k=
