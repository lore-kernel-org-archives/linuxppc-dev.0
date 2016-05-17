Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r88dx2DRtzDqGQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 17:51:01 +1000 (AEST)
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Tue, 17 May 2016 13:20:58 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 2F10F3940073
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 13:20:57 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4H7osZI54067296
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 13:20:55 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4H7omI9017652
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 13:20:54 +0530
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com, mnipxh@163.com, boqun.feng@gmail.com,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v2 2/6] powerpc: pseries/Kconfig: qspinlock build config
Date: Tue, 17 May 2016 15:49:43 +0800
Message-Id: <1463471387-5115-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
In-Reply-To: <1463471387-5115-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1463471387-5115-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pseries will use qspinlock by default.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index bec90fb..f669323 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -21,6 +21,7 @@ config PPC_PSERIES
 	select HOTPLUG_CPU if SMP
 	select ARCH_RANDOM
 	select PPC_DOORBELL
+	select ARCH_USE_QUEUED_SPINLOCKS
 	default y
 
 config PPC_SPLPAR
-- 
1.9.1
