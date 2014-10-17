Return-Path: <ddstreet@gmail.com>
Received: from mail-ig0-x22e.google.com (mail-ig0-x22e.google.com
 [IPv6:2607:f8b0:4001:c05::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75B911A02BA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Oct 2014 10:20:31 +1100 (AEDT)
Received: by mail-ig0-f174.google.com with SMTP id a13so2498748igq.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 16:20:28 -0700 (PDT)
Sender: Dan Streetman <ddstreet@gmail.com>
From: Dan Streetman <ddstreet@ieee.org>
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 nfont@linux.vnet.ibm.com
Subject: [PATCH] MAINTAINERS: nx-842 driver maintainer change
Date: Fri, 17 Oct 2014 19:19:59 -0400
Message-Id: <1413587999-12684-1-git-send-email-ddstreet@ieee.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Dan Streetman <ddstreet@ieee.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change maintainer of nx-842 compression coprocessor driver
to Dan Streetman.

Signed-off-by: Dan Streetman <ddstreet@ieee.org>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b0f17d5..3cc3e41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4605,7 +4605,7 @@ S:	Supported
 F:	drivers/crypto/nx/
 
 IBM Power 842 compression accelerator
-M:	Nathan Fontenot <nfont@linux.vnet.ibm.com>
+M:	Dan Streetman <ddstreet@us.ibm.com>
 S:	Supported
 F:	drivers/crypto/nx/nx-842.c
 F:	include/linux/nx842.h
-- 
1.8.3.1
