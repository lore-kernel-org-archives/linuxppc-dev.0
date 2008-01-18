Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1F109DDEF9
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 01:31:37 +1100 (EST)
Message-ID: <4790B862.8080004@scram.de>
Date: Fri, 18 Jan 2008 15:32:02 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH 4/7] [POWERPC] Remove declaration of m8xx_pic_init.
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

m8xx_pic_init is declared in ppc8xx_pic.h but defined nowhere in the ppc
tree. Remove it.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/ppc/syslib/ppc8xx_pic.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/syslib/ppc8xx_pic.h b/arch/ppc/syslib/ppc8xx_pic.h
index d7d9f65..53bcd97 100644
--- a/arch/ppc/syslib/ppc8xx_pic.h
+++ b/arch/ppc/syslib/ppc8xx_pic.h
@@ -6,7 +6,6 @@
 
 extern struct hw_interrupt_type ppc8xx_pic;
 
-void m8xx_pic_init(void);
 void m8xx_do_IRQ(struct pt_regs *regs,
                  int            cpu);
 int m8xx_get_irq(struct pt_regs *regs);
-- 
1.5.3.8
