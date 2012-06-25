Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D2C00B6FF8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 22:26:50 +1000 (EST)
Received: from mail99-ch1 (localhost [127.0.0.1])	by mail99-ch1-R.bigfish.com
 (Postfix) with ESMTP id 346334002D5	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,
 25 Jun 2012 12:25:08 +0000 (UTC)
Received: from CH1EHSMHS003.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.231])	by mail99-ch1.bigfish.com (Postfix) with ESMTP id
 887728005E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:06 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q5PCQfNU003917	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 05:26:42 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <qemu-ppc@nongnu.org>
Subject: [RFC PATCH 17/17] KVM: PPC: booke: Fix get_tb() compile error on
 64-bit
Date: Mon, 25 Jun 2012 15:26:35 +0300
Message-ID: <1340627195-11544-18-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>
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
index db05692..a427031 100644
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
