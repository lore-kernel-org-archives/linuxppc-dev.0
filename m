Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 04925DDE02
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 20:18:35 +1100 (EST)
To: torvalds@linux-foundation.org
Subject: [PATCH 4/17] constant should be long
Message-Id: <E1HRPcs-0003QH-0N@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 14 Mar 2007 09:18:30 +0000
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/kernel/udbg_16550.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/udbg_16550.c b/arch/powerpc/kernel/udbg_16550.c
index e738f93..a963f65 100644
--- a/arch/powerpc/kernel/udbg_16550.c
+++ b/arch/powerpc/kernel/udbg_16550.c
@@ -184,7 +184,7 @@ void udbg_pas_real_putc(char c)
 
 void udbg_init_pas_realmode(void)
 {
-	udbg_comport = (volatile struct NS16550 __iomem *)0xfcff03f8;
+	udbg_comport = (volatile struct NS16550 __iomem *)0xfcff03f8UL;
 
 	udbg_putc = udbg_pas_real_putc;
 	udbg_getc = NULL;
-- 
1.5.0-rc2.GIT
