Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A0622DE524
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 10:58:27 +1100 (EST)
Date: Wed, 7 Jan 2009 10:58:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/cell: fix the prototype of create_vma_map
Message-Id: <20090107105822.221c4395.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/oprofile/cell/pr_util.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/oprofile/cell/pr_util.h b/arch/powerpc/oprofile/cell/pr_util.h
index 628009c..dfdbffa 100644
--- a/arch/powerpc/oprofile/cell/pr_util.h
+++ b/arch/powerpc/oprofile/cell/pr_util.h
@@ -79,7 +79,7 @@ struct spu_buffer {
  * the vma-to-fileoffset map.
  */
 struct vma_to_fileoffset_map *create_vma_map(const struct spu *spu,
-					     u64 objectid);
+					     unsigned long objectid);
 unsigned int vma_map_lookup(struct vma_to_fileoffset_map *map,
 			    unsigned int vma, const struct spu *aSpu,
 			    int *grd_val);
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
