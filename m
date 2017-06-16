Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wprlx5lJjzDq8V
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 16:57:33 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id s66so4436342pfs.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 23:57:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Don Zickus <dzickus@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Babu Moger <babu.moger@oracle.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 1/5] watchdog: remove unused declaration
Date: Fri, 16 Jun 2017 16:57:11 +1000
Message-Id: <20170616065715.18390-2-npiggin@gmail.com>
In-Reply-To: <20170616065715.18390-1-npiggin@gmail.com>
References: <20170616065715.18390-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/linux/nmi.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index aa3cd0878270..5e2e57536d98 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -12,9 +12,6 @@ extern void touch_softlockup_watchdog_sched(void);
 extern void touch_softlockup_watchdog(void);
 extern void touch_softlockup_watchdog_sync(void);
 extern void touch_all_softlockup_watchdogs(void);
-extern int proc_dowatchdog_thresh(struct ctl_table *table, int write,
-				  void __user *buffer,
-				  size_t *lenp, loff_t *ppos);
 extern unsigned int  softlockup_panic;
 extern unsigned int  hardlockup_panic;
 void lockup_detector_init(void);
-- 
2.11.0
