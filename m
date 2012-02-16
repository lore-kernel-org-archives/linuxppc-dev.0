Return-Path: <danny.kukawka@bisect.de>
Received: from wp188.webpack.hosteurope.de (wp188.webpack.hosteurope.de
 [IPv6:2a01:488:42::50ed:84c3])
 by ozlabs.org (Postfix) with ESMTP id BB9ABB6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 01:12:47 +1100 (EST)
From: Danny Kukawka <danny.kukawka@bisect.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] arch/powerpc/platforms/powernv/setup.c: included asm/xics.h
 twice
Date: Thu, 16 Feb 2012 14:56:03 +0100
Message-Id: <1329400563-31959-1-git-send-email-danny.kukawka@bisect.de>
Cc: Paul Mackerras <paulus@samba.org>, Danny Kukawka <dkukawka@suse.de>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/powerpc/platforms/powernv/setup.c: included 'asm/xics.h' twice,
remove the duplicate.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 arch/powerpc/platforms/powernv/setup.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 467bd4a..db1ad1c 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -31,7 +31,6 @@
 #include <asm/xics.h>
 #include <asm/rtas.h>
 #include <asm/opal.h>
-#include <asm/xics.h>
 
 #include "powernv.h"
 
-- 
1.7.8.3
