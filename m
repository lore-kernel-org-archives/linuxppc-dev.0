Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <d35bdbd4be04065ab67b93b7a6a876a000dc4cf1.1196839256.git.michael@ellerman.id.au>
In-Reply-To: <ac4252cfbaa0c1a3534443007417dfc43b597eb5.1196839256.git.michael@ellerman.id.au>
References: <ac4252cfbaa0c1a3534443007417dfc43b597eb5.1196839256.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 7/7] Remove bogus comment in dma_direct_alloc_coherent()
Date: Wed,  5 Dec 2007 18:21:07 +1100 (EST)
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
index 26c0d8c..1ef919d 100644
--- a/arch/powerpc/kernel/dma_64.c
+++ b/arch/powerpc/kernel/dma_64.c
@@ -137,7 +137,6 @@ static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 	void *ret;
 	int node = dev->archdata.numa_node;
 
-	/* TODO: Maybe use the numa node here too ? */
 	page = alloc_pages_node(node, flag, get_order(size));
 	if (page == NULL)
 		return NULL;
-- 
1.5.3.7.1.g4e596e
