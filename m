Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qWc6l4wVqzDq71
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Mar 2016 19:34:39 +1100 (AEDT)
Received: by mail-pa0-x244.google.com with SMTP id q6so5968579pav.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Mar 2016 01:34:39 -0700 (PDT)
Date: Fri, 25 Mar 2016 01:12:21 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, simonguo@linux.vnet.ibm.com,
 Simon Guo <wei.guo.simon@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: correct VSX used_vsr comment
Message-ID: <20160324171221.GB10758@simonLocalRHEL7.x64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

used_vsr flag is set if process has used VSX register, 
instead of Altivec register. 
This patch corrects the wrong comment.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index ac23308..a3a25e4 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -244,7 +244,7 @@ struct thread_struct {
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_VSX
 	/* VSR status */
-	int		used_vsr;	/* set if process has used altivec */
+	int		used_vsr;	/* set if process has used VSX */
 #endif /* CONFIG_VSX */
 #ifdef CONFIG_SPE
 	unsigned long	evr[32];	/* upper 32-bits of SPE regs */
-- 
1.8.3.1
