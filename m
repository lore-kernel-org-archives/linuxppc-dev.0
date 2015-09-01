Return-Path: <joel@jms.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB1281A1BE7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 14:23:38 +1000 (AEST)
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4096314076C
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Sep 2015 14:23:38 +1000 (AEST)
Received: by paczk9 with SMTP id zk9so14058316pac.0
 for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2015 21:23:36 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: anton@samba.org
Cc: linuxppc-dev@ozlabs.org
Subject: [kexec-lite 3/3] Bump version to 1.0
Date: Tue,  1 Sep 2015 13:53:09 +0930
Message-Id: <1441081389-17131-3-git-send-email-joel@jms.id.au>
In-Reply-To: <1441081389-17131-1-git-send-email-joel@jms.id.au>
References: <1441081389-17131-1-git-send-email-joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec.c b/kexec.c
index a9f108e..d87d617 100644
--- a/kexec.c
+++ b/kexec.c
@@ -40,7 +40,7 @@
 #include "kexec_memory_map.h"
 #include "kexec_trampoline.h"
 
-#define VERSION "0.0.2"
+#define VERSION "1.0.0"
 
 #define PROC_DEVICE_TREE "/proc/device-tree"
 #define RESERVED_REGIONS "30"
-- 
2.5.0
