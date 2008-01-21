Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <f62c2a7477a956c09fe9286922c350465a60dacd.1200894155.git.michael@ellerman.id.au>
In-Reply-To: <2949748ba6ad7e14f0768ac3889267e42c050d7a.1200894155.git.michael@ellerman.id.au>
References: <2949748ba6ad7e14f0768ac3889267e42c050d7a.1200894155.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 7/7] Remove bogus comment in dma_direct_alloc_coherent()
Date: Mon, 21 Jan 2008 16:42:49 +1100 (EST)
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since commit c80d9133e99de1af607314107910a2a1645efb17 (Make direct DMA use
node local allocations) went in this comment makes no sense.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/dma_64.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/dma_64.c b/arch/powerpc/kernel/dma_64.c
index 72fdc06..8423907 100644
--- a/arch/powerpc/kernel/dma_64.c
+++ b/arch/powerpc/kernel/dma_64.c
@@ -130,7 +130,6 @@ static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 	void *ret;
 	int node = dev->archdata.numa_node;
 
-	/* TODO: Maybe use the numa node here too ? */
 	page = alloc_pages_node(node, flag, get_order(size));
 	if (page == NULL)
 		return NULL;
-- 
1.5.2.rc1.1884.g59b20
