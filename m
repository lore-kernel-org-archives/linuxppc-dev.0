Return-Path: <justinmattock@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id AEC4AB7217
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 03:43:39 +1100 (EST)
Received: by ywp27 with SMTP id 27so5072822ywp.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2011 08:43:36 -0800 (PST)
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: trivial@kernel.org
Subject: [PATCH 1/3]arch:powerpc:sysdev:mpic.c Remove extra semicolon.
Date: Mon, 21 Nov 2011 08:43:26 -0800
Message-Id: <1321893808-3721-1-git-send-email-justinmattock@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Justin P. Mattock" <justinmattock@gmail.com>

The patch below removes an extra semicolon.

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
CC: linuxppc-dev@lists.ozlabs.org
CC: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/sysdev/mpic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 8c7e852..b3fa3d7 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -901,7 +901,7 @@ int mpic_set_irq_type(struct irq_data *d, unsigned int flow_type)
 	if (vold != vnew)
 		mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI), vnew);
 
-	return IRQ_SET_MASK_OK_NOCOPY;;
+	return IRQ_SET_MASK_OK_NOCOPY;
 }
 
 void mpic_set_vector(unsigned int virq, unsigned int vector)
-- 
1.7.5.4
