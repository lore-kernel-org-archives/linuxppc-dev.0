Return-Path: <olof@lixom.net>
Date: Wed, 12 Apr 2006 15:21:06 -0500
To: paulus@ozlabs.org
Subject: [3/10]: Quiet page order output
Message-ID: <20060412202106.GJ19464@pb15.lixom.net>
References: <20060412201823.GG19464@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060412201823.GG19464@pb15.lixom.net>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

No need to always print page orders.

Signed-off-by: Olof Johansson <olof@lixom.net>


Index: 2.6/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- 2.6.orig/arch/powerpc/mm/hash_utils_64.c
+++ 2.6/arch/powerpc/mm/hash_utils_64.c
@@ -319,7 +319,7 @@ static void __init htab_init_page_sizes(
 		mmu_virtual_psize = MMU_PAGE_64K;
 #endif
 
-	printk(KERN_INFO "Page orders: linear mapping = %d, others = %d\n",
+	printk(KERN_DEBUG "Page orders: linear mapping = %d, others = %d\n",
 	       mmu_psize_defs[mmu_linear_psize].shift,
 	       mmu_psize_defs[mmu_virtual_psize].shift);
 
