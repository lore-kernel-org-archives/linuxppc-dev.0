Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0D0F2DDE33
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 08:00:38 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1Ik5K6-0000EE-DL
	for linuxppc-dev@ozlabs.org; Mon, 22 Oct 2007 17:00:35 -0500
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] DTC: Remove an unneeded %token definition.
Date: Mon, 22 Oct 2007 17:00:34 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Ik5K6-0000EE-DL@jdl.com>
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
 dtc-parser.y |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/dtc-parser.y b/dtc-parser.y
index c213526..61ed250 100644
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -55,7 +55,6 @@ extern struct boot_info *the_boot_info;
 %token <str> DT_CELL
 %token <byte> DT_BYTE
 %token <data> DT_STRING
-%token <str> DT_UNIT
 %token <str> DT_LABEL
 %token <str> DT_REF
 
-- 
1.5.3.1.139.g9346b
