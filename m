Return-Path: <B11780@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 193562C038D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 23:01:42 +1000 (EST)
Received: from mail75-ch1 (localhost [127.0.0.1])	by mail75-ch1-R.bigfish.com
 (Postfix) with ESMTP id 6185A100127	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 13 Jul 2012 13:01:37 +0000 (UTC)
Received: from CH1EHSMHS008.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.235])	by mail75-ch1.bigfish.com (Postfix) with ESMTP id
 718384800DE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 13:01:35 +0000 (UTC)
From: Kumar Gala <kumar.gala@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Subject: P1022DS board support upstream?
Date: Fri, 13 Jul 2012 08:01:36 -0500
Message-ID: <1F81EF77-1E39-4D16-BB8B-24D5CA53F929@freescale.com>
To: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
MIME-Version: 1.0 (Apple Message framework v1278)
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Is the functionality of all of these SDK patches upstream now?

[ ignore commit id's ]

b257909 powerpc/85xx: p1022ds: disable the NAND flash node if video is =
enabled
ee260f4 powerpc/mpc85xx: p1022ds support the MTD for NOR and NAND flash
4be8bb6 powerpc/mpc85xx: 32bit address support for p1022ds
25f9408 powerpc/85xx: fix PCI and localbus properties in p1022ds.dts
1bcb442 powerpc/p1022ds/DTS: Add RTC support
05e5bc8 powerpc/85xx: create 32-bit DTS for the P1022DS
79111f3 powerpc/85xx: p1022ds: disable the NOR flash node if video is =
enabled

- k=
