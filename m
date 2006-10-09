Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D1CCA67B5B
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 01:22:13 +1000 (EST)
Date: Mon, 9 Oct 2006 16:22:09 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] extern doesn't make sense on a definition of function...
Message-ID: <20061009152209.GP29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
 arch/powerpc/kernel/irq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 829ac18..5e37bf1 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -572,8 +572,8 @@ unsigned int irq_create_mapping(struct i
 }
 EXPORT_SYMBOL_GPL(irq_create_mapping);
 
-extern unsigned int irq_create_of_mapping(struct device_node *controller,
-					  u32 *intspec, unsigned int intsize)
+unsigned int irq_create_of_mapping(struct device_node *controller,
+				   u32 *intspec, unsigned int intsize)
 {
 	struct irq_host *host;
 	irq_hw_number_t hwirq;
-- 
1.4.2.GIT
