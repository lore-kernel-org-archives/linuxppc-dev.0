Return-Path: <joel@jms.id.au>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
 [209.85.192.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DE7971402C1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:26:03 +1000 (EST)
Received: by mail-pd0-f180.google.com with SMTP id v10so1649520pde.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 00:26:01 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: benh@kernel.crashing.org
Subject: [PATCH 4/5] powerpc/powernv: Fix typos in sysparam code
Date: Thu, 24 Apr 2014 16:55:36 +0930
Message-Id: <1398324337-896-5-git-send-email-joel@jms.id.au>
In-Reply-To: <1398324337-896-1-git-send-email-joel@jms.id.au>
References: <1398324337-896-1-git-send-email-joel@jms.id.au>
Cc: neelegup@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

---
 arch/powerpc/platforms/powernv/opal-sysparam.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-sysparam.c b/arch/powerpc/platforms/powernv/opal-sysparam.c
index 21fdc0a..4b3367b 100644
--- a/arch/powerpc/platforms/powernv/opal-sysparam.c
+++ b/arch/powerpc/platforms/powernv/opal-sysparam.c
@@ -222,13 +222,13 @@ void __init opal_sys_param_init(void)
 	}
 
 	if (of_property_read_u32_array(sysparam, "param-len", size, count)) {
-		pr_err("SYSPARAM: Missing propery param-len in the DT\n");
+		pr_err("SYSPARAM: Missing property param-len in the DT\n");
 		goto out_free_perm;
 	}
 
 
 	if (of_property_read_u8_array(sysparam, "param-perm", perm, count)) {
-		pr_err("SYSPARAM: Missing propery param-perm in the DT\n");
+		pr_err("SYSPARAM: Missing property param-perm in the DT\n");
 		goto out_free_perm;
 	}
 
-- 
1.9.1
