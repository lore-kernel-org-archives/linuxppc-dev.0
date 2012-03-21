Return-Path: <koct9i@gmail.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F3790B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 17:57:01 +1100 (EST)
Received: by bkwj10 with SMTP id j10so662578bkw.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2012 23:56:57 -0700 (PDT)
Sender: Konstantin Khlebnikov <koct9i@gmail.com>
Subject: [PATCH 10/16] mm/powerpc: use vm_flags_t for vma flags
To: Andrew Morton <akpm@linux-foundation.org>
From: Konstantin Khlebnikov <khlebnikov@openvz.org>
Date: Wed, 21 Mar 2012 10:56:54 +0400
Message-ID: <20120321065653.13852.20099.stgit@zurg>
In-Reply-To: <20120321065140.13852.52315.stgit@zurg>
References: <20120321065140.13852.52315.stgit@zurg>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Konstantin Khlebnikov <khlebnikov@openvz.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/mman.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
index d4a7f64..451de1c 100644
--- a/arch/powerpc/include/asm/mman.h
+++ b/arch/powerpc/include/asm/mman.h
@@ -44,7 +44,7 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot)
 }
 #define arch_calc_vm_prot_bits(prot) arch_calc_vm_prot_bits(prot)
 
-static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
+static inline pgprot_t arch_vm_get_page_prot(vm_flags_t vm_flags)
 {
 	return (vm_flags & VM_SAO) ? __pgprot(_PAGE_SAO) : __pgprot(0);
 }
