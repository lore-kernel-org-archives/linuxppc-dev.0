Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C5D081A000B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 19:52:24 +1100 (AEDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] MAINTAINERS: rename EEH from "enhanced" to "extended" error
 handling
Date: Tue, 16 Feb 2016 19:52:00 +1100
Message-Id: <1455612720-3758-1-git-send-email-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Incredibly, IBM online documentation for EEH uses "extended error handling"
and "enhanced error handling" to refer to the same thing, in different
places.  In other parts of the kernel, namely the EEH documentation (found
in Documentation/powerpc/eeh-pci-error-recovery.txt), it's referred to as
"extended", and in my opinion "extended" makes more sense for what EEH
does.

The only place "enhanced error handling" shows up in the kernel is in
MAINTAINERS, so fix it.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
I don't know what kind of things parse MAINTAINERS, and if there's a chance
this will break them.  Also, the powerpc tree *is* the right place to send
this, right?
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 28eb61b..e5d9134 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4222,7 +4222,7 @@ M:	Maxim Levitsky <maximlevitsky@gmail.com>
 S:	Maintained
 F:	drivers/media/rc/ene_ir.*
 
-ENHANCED ERROR HANDLING (EEH)
+EXTENDED ERROR HANDLING (EEH)
 M:	Gavin Shan <shangw@linux.vnet.ibm.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
-- 
2.7.1
