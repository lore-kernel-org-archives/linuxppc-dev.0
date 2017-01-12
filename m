Return-Path: <weiyj.lk@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzq146ZLFzDqVx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 02:09:28 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id b22so3913123pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 07:09:28 -0800 (PST)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH -next] powerpc/pseries: Fix typo in parameter description
Date: Thu, 12 Jan 2017 15:09:21 +0000
Message-Id: <20170112150921.7427-1-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix typo in parameter description.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 arch/powerpc/platforms/pseries/cmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 66e7227..7af18da 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -74,7 +74,7 @@ module_param_named(delay, delay, uint, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(delay, "Delay (in seconds) between polls to query hypervisor paging requests. "
 		 "[Default=" __stringify(CMM_DEFAULT_DELAY) "]");
 module_param_named(hotplug_delay, hotplug_delay, uint, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(delay, "Delay (in seconds) after memory hotplug remove "
+MODULE_PARM_DESC(hotplug_delay, "Delay (in seconds) after memory hotplug remove "
 		 "before loaning resumes. "
 		 "[Default=" __stringify(CMM_HOTPLUG_DELAY) "]");
 module_param_named(oom_kb, oom_kb, uint, S_IRUGO | S_IWUSR);
