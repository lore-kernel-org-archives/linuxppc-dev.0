Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <56662c291890f09835ef7251f9b86f70fbee3ad2.1201616038.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/8] Add set_dma_ops() to match get_dma_ops().
Date: Wed, 30 Jan 2008 01:13:58 +1100 (EST)
Cc: cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 include/asm-powerpc/dma-mapping.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/dma-mapping.h b/include/asm-powerpc/dma-mapping.h
index 5eea6db..bbefb69 100644
--- a/include/asm-powerpc/dma-mapping.h
+++ b/include/asm-powerpc/dma-mapping.h
@@ -76,6 +76,11 @@ static inline struct dma_mapping_ops *get_dma_ops(struct device *dev)
 	return dev->archdata.dma_ops;
 }
 
+static inline void set_dma_ops(struct device *dev, struct dma_mapping_ops *ops)
+{
+	dev->archdata.dma_ops = ops;
+}
+
 static inline int dma_supported(struct device *dev, u64 mask)
 {
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
-- 
1.5.3.7.1.g4e596e
