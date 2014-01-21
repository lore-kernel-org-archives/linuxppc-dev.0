Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 23A722C0327
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 08:25:20 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 39/73] powerpc: delete another unrequired instance of
 <linux/init.h>
Date: Tue, 21 Jan 2014 16:22:42 -0500
Message-ID: <1390339396-3479-40-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-arch@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Most were already deleted in the 1st pass audit; this instance
showed up more recently.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/sysdev/indirect_pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/sysdev/indirect_pci.c b/arch/powerpc/sysdev/indirect_pci.c
index 1f6c570..66f5fd1 100644
--- a/arch/powerpc/sysdev/indirect_pci.c
+++ b/arch/powerpc/sysdev/indirect_pci.c
@@ -13,7 +13,6 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/string.h>
-#include <linux/init.h>
 
 #include <asm/io.h>
 #include <asm/prom.h>
-- 
1.8.4.1
