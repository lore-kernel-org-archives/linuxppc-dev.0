Return-Path: <B32579@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
 [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 08714B6F71
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Dec 2011 15:59:57 +1100 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-mtd@lists.infradead.org>
Subject: mtd/NAND:Fix issues with freescale IFC to support NAND 2K 
Date: Thu, 29 Dec 2011 10:29:37 +0530
Message-ID: <1325134779-3571-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This Patch series takes care issues with Freescale IFC driver for supporting 2K
page size NAND with ECC enabled.

[PATCH 1/2] mtd/nand:Fix wrong address read in is_blank()
  Fix driver issue when ECC enabled.

[PATCH 2/2] mtd/nand: Fix IFC driver to support 2K NAND page
  Fix driver during OOB updation
