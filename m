Return-Path: <weiyi.huang@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0C923B723E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 21 Jun 2009 09:37:17 +1000 (EST)
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by ozlabs.org (Postfix) with ESMTP id 761D7DDD0C
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Jun 2009 09:37:15 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so933951wfg.15
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2009 16:37:13 -0700 (PDT)
From: Huang Weiyi <weiyi.huang@gmail.com>
To: paulus@samba.org,
	benh@kernel.crashing.org
Subject: [PATCH] perf_counter: powerpc: remove duplicated #include
Date: Sun, 21 Jun 2009 07:37:00 +0800
Message-Id: <1245541020-2504-1-git-send-email-weiyi.huang@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Huang Weiyi <weiyi.huang@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove duplicated #include('s) in
  arch/powerpc/kernel/mpc7450-pmu.c
  arch/powerpc/kernel/ppc970-pmu.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/powerpc/kernel/mpc7450-pmu.c |    1 -
 arch/powerpc/kernel/ppc970-pmu.c  |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/mpc7450-pmu.c b/arch/powerpc/kernel/mpc7450-pmu.c
index 75ff47f..c244133 100644
--- a/arch/powerpc/kernel/mpc7450-pmu.c
+++ b/arch/powerpc/kernel/mpc7450-pmu.c
@@ -10,7 +10,6 @@
  */
 #include <linux/string.h>
 #include <linux/perf_counter.h>
-#include <linux/string.h>
 #include <asm/reg.h>
 #include <asm/cputable.h>
 
diff --git a/arch/powerpc/kernel/ppc970-pmu.c b/arch/powerpc/kernel/ppc970-pmu.c
index 6637c87..833097a 100644
--- a/arch/powerpc/kernel/ppc970-pmu.c
+++ b/arch/powerpc/kernel/ppc970-pmu.c
@@ -10,7 +10,6 @@
  */
 #include <linux/string.h>
 #include <linux/perf_counter.h>
-#include <linux/string.h>
 #include <asm/reg.h>
 #include <asm/cputable.h>
 
-- 
1.6.1.2
