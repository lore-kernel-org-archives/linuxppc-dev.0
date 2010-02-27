Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-bw0-f211.google.com (mail-bw0-f211.google.com
	[209.85.218.211]) by ozlabs.org (Postfix) with ESMTP id 365DBB7D78
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Feb 2010 03:56:15 +1100 (EST)
Received: by bwz3 with SMTP id 3so771336bwz.9
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2010 08:56:13 -0800 (PST)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 44/66] arch/powerpc/sysdev/cpm2_pic.h: Checkpatch cleanup
Date: Sat, 27 Feb 2010 17:51:25 +0100
Message-Id: <1267289508-31031-45-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/powerpc/sysdev/cpm2_pic.h:6: ERROR: "(foo*)" should be "(foo *)"

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/powerpc/sysdev/cpm2_pic.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2_pic.h b/arch/powerpc/sysdev/cpm2_pic.h
index 30e5828..2c5f70c 100644
--- a/arch/powerpc/sysdev/cpm2_pic.h
+++ b/arch/powerpc/sysdev/cpm2_pic.h
@@ -3,6 +3,6 @@
 
 extern unsigned int cpm2_get_irq(void);
 
-extern void cpm2_pic_init(struct device_node*);
+extern void cpm2_pic_init(struct device_node *);
 
 #endif /* _PPC_KERNEL_CPM2_H */
-- 
1.7.0.90.g251a4
