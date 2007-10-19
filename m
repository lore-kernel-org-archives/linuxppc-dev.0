Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2E05CDE303
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 03:43:17 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1IivsP-00078Q-Hf
	for linuxppc-dev@ozlabs.org; Fri, 19 Oct 2007 12:43:14 -0500
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4] DTC: Appease the printf() format $Gods with a correct
	type.
Date: Fri, 19 Oct 2007 12:43:13 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IivsP-00078Q-Hf@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 tests/get_name.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tests/get_name.c b/tests/get_name.c
index 2481741..a76bdf8 100644
--- a/tests/get_name.c
+++ b/tests/get_name.c
@@ -55,7 +55,7 @@ void check_name(void *fdt, const char *path)
 
 	if (len != strlen(getname))
 		FAIL("fdt_get_name(%s) returned length %d instead of %d",
-		     path, len, strlen(getname));
+		     path, len, (int) strlen(getname));
 
 	/* Now check that it doesn't break if we omit len */
 	getname2 = fdt_get_name(fdt, offset, NULL);
-- 
1.5.3.1.139.g9346b
