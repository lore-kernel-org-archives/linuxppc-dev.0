Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 46A80DDDED
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 12:06:02 +1100 (EST)
Date: Fri, 18 Jan 2008 12:06:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Fix a couple of copyright symbols
Message-Id: <20080118120601.a45765ef.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/systbl_chk.c  |    2 +-
 arch/powerpc/kernel/systbl_chk.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Patchwork strikes again. :-(

diff --git a/arch/powerpc/kernel/systbl_chk.c b/arch/powerpc/kernel/systbl_chk.c
index 77824d1..238aa63 100644
--- a/arch/powerpc/kernel/systbl_chk.c
+++ b/arch/powerpc/kernel/systbl_chk.c
@@ -6,7 +6,7 @@
  * Unfortunately, we cannot check for the correct ordering of entries
  * using SYSX().
  *
- * Copyright Â© IBM Corporation
+ * Copyright © IBM Corporation
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
diff --git a/arch/powerpc/kernel/systbl_chk.sh b/arch/powerpc/kernel/systbl_chk.sh
index 367d208..19415e7 100644
--- a/arch/powerpc/kernel/systbl_chk.sh
+++ b/arch/powerpc/kernel/systbl_chk.sh
@@ -3,7 +3,7 @@
 # Just process the CPP output from systbl_chk.c and complain
 # if anything is out of order.
 #
-# Copyright Â© 2008 IBM Corporation
+# Copyright © 2008 IBM Corporation
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
-- 
1.5.3.8

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
