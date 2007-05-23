Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id ECAEDDDE06
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 06:00:34 +1000 (EST)
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
To: mingo@elte.hu, tglx@linutronix.de
Subject: [PATCH 2.6.21-rt7] PowerPC: kill cpu_khz reference
Date: Wed, 23 May 2007 23:02:00 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705240002.00698.sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove forgotten reference to 'cpu_khz' which have been removed for PowerPC in
2.6.21-rt7...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The irony here is that it was me who sent a patch to add that line. :-)

Index: linux-2.6/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/time.c
+++ linux-2.6/arch/powerpc/kernel/time.c
@@ -816,7 +816,6 @@ void __init time_init(void)
 	tb_ticks_per_jiffy = ppc_tb_freq / HZ;
 	tb_ticks_per_sec = ppc_tb_freq;
 	tb_ticks_per_usec = ppc_tb_freq / 1000000;
-	cpu_khz  = ppc_tb_freq / 1000;
 	tb_to_us = mulhwu_scale_factor(ppc_tb_freq, 1000000);
 	calc_cputime_factors();
 
