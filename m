Return-Path: <geert@linux-m68k.org>
Received: from wilson.telenet-ops.be (wilson.telenet-ops.be [195.130.132.42])
 by ozlabs.org (Postfix) with ESMTP id 5639A2C0362
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Oct 2013 18:40:29 +1100 (EST)
Received: from juliette.telenet-ops.be (juliette.telenet-ops.be
 [195.130.137.74])
 by wilson.telenet-ops.be (Postfix) with ESMTP id 8DD2B34955D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Oct 2013 09:40:24 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/kexec: kexec_sequence() is in misc_64.S
Date: Mon, 14 Oct 2013 09:40:16 +0200
Message-Id: <1381736416-4088-1-git-send-email-geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Correct reference to the location of the kexec_sequence() assembly helper.
There never was a kexec_stub.S in mainline.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/powerpc/kernel/machine_kexec_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 611acdf30096..be4e6d648f60 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -312,7 +312,7 @@ static union thread_union kexec_stack __init_task_data =
  */
 struct paca_struct kexec_paca;
 
-/* Our assembly helper, in kexec_stub.S */
+/* Our assembly helper, in misc_64.S */
 extern void kexec_sequence(void *newstack, unsigned long start,
 			   void *image, void *control,
 			   void (*clear_all)(void)) __noreturn;
-- 
1.7.9.5
