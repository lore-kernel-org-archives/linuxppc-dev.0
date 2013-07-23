Return-Path: <B40534@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 37CC62C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 20:19:41 +1000 (EST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <daniel.lezcano@linaro.org>
Subject: [PATCH 2/2] cpuidle: export cpuidle_idle_call symbol
Date: Tue, 23 Jul 2013 17:28:01 +0800
Message-ID: <1374571681-31911-2-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1374571681-31911-1-git-send-email-dongsheng.wang@freescale.com>
References: <1374571681-31911-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: rjw@sisk.pl, linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

Export cpuidle_idle_call symbol, make this function can be invoked
in the module.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
Branch: pm-cpuidle

 drivers/cpuidle/cpuidle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 534320a..d0a61d6 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -168,6 +168,7 @@ int cpuidle_idle_call(void)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cpuidle_idle_call);
 
 /**
  * cpuidle_install_idle_handler - installs the cpuidle idle loop handler
-- 
1.8.0
