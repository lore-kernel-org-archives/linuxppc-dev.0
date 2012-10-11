Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 180D92C03F4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 03:14:36 +1100 (EST)
Received: from mail215-ch1 (localhost [127.0.0.1])	by
 mail215-ch1-R.bigfish.com (Postfix) with ESMTP id 085282A00BF	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:21 +0000 (UTC)
Received: from CH1EHSMHS035.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.232])	by mail215-ch1.bigfish.com (Postfix) with ESMTP id
 74E6C4E007E	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:17
 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q9BGEEAD028169	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 09:14:15 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 02/12] KVM: PPC: booke: Fix get_tb() compile error on 64-bit
Date: Thu, 11 Oct 2012 19:13:19 +0300
Message-ID: <1349972009-23027-3-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
References: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Include header file for get_tb() declaration.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/booke.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 3d1f35d..7c9c389 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -36,6 +36,7 @@
 #include <asm/dbell.h>
 #include <asm/hw_irq.h>
 #include <asm/irq.h>
+#include <asm/time.h>
 
 #include "timing.h"
 #include "booke.h"
-- 
1.7.4.1
