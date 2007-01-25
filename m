Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 93C9BDDFA6
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 15:31:00 +1100 (EST)
Message-ID: <45B81898.8000801@am.sony.com>
Date: Wed, 24 Jan 2007 18:40:24 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH 12/14] ps3: fix gpu_context_allocate hcall
Content-Type: text/plain; charset=ISO-8859-1
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

PS3: lv1_gpu_context_allocate() takes only one input parameter

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 include/asm-powerpc/lv1call.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- ps3-linux-dev.orig/include/asm-powerpc/lv1call.h
+++ ps3-linux-dev/include/asm-powerpc/lv1call.h
@@ -307,7 +307,7 @@ LV1_CALL(gpu_device_map,                
 LV1_CALL(gpu_device_unmap,                              1, 0, 213 )
 LV1_CALL(gpu_memory_allocate,                           5, 2, 214 )
 LV1_CALL(gpu_memory_free,                               1, 0, 216 )
-LV1_CALL(gpu_context_allocate,                          2, 5, 217 )
+LV1_CALL(gpu_context_allocate,                          1, 5, 217 )
 LV1_CALL(gpu_context_free,                              1, 0, 218 )
 LV1_CALL(gpu_context_iomap,                             5, 0, 221 )
 LV1_CALL(gpu_context_attribute,                         6, 0, 225 )
