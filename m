Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D709BDE1A5
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 03:43:02 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1IivsA-00078F-ST
	for linuxppc-dev@ozlabs.org; Fri, 19 Oct 2007 12:42:59 -0500
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4] DTC: Quiet a bogus "May be used uninitialized" warning.
Date: Fri, 19 Oct 2007 12:42:58 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IivsA-00078F-ST@jdl.com>
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
 flattree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/flattree.c b/flattree.c
index a26e71b..5889900 100644
--- a/flattree.c
+++ b/flattree.c
@@ -136,7 +136,7 @@ static void asm_emit_cell(void *e, cell_t val)
 static void asm_emit_string(void *e, char *str, int len)
 {
 	FILE *f = e;
-	char c;
+	char c = 0;
 
 	if (len != 0) {
 		/* XXX: ewww */
-- 
1.5.3.1.139.g9346b
