Return-Path: <cyrilbur@gmail.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C4BCE1A033E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 16:44:17 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Mon, 4 May 2015 16:44:15 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8C532357804C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 16:44:11 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t446i2VS19464276
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 May 2015 16:44:11 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t446hcSW016253
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 May 2015 16:43:38 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Add a MTD driver for OpenPower PNOR flash
Date: Mon,  4 May 2015 16:42:18 +1000
Message-Id: <1430721739-17517-1-git-send-email-cyrilbur@gmail.com>
Cc: dwmw2@infradead.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm resending the patch that Jeremy Kerr sent a while back.

This patch implements a simple mtd device to allow access to the PNOR
flash on OpenPower machines. The flash is accessed through firmware
calls.

The firmware calls are already merged in:
commit ed59190e41b725e1cfd79541f5fc66c20adb0671
Author: Cyril Bur <cyrilbur@gmail.com>
Date:   Wed Apr 1 14:05:30 2015 +0800

    powerpc/powernv: Add interfaces for flash device access

Cheers,

Cyril



Cyril Bur (1):
  drivers/mtd: add powernv flash MTD abstraction driver

 drivers/mtd/devices/Kconfig         |   6 +
 drivers/mtd/devices/Makefile        |   1 +
 drivers/mtd/devices/powernv_flash.c | 288 ++++++++++++++++++++++++++++++++++++
 3 files changed, 295 insertions(+)
 create mode 100644 drivers/mtd/devices/powernv_flash.c

-- 
1.9.1
