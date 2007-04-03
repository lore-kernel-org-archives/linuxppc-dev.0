Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 21764DE045
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 22:52:43 +1000 (EST)
Date: Tue, 3 Apr 2007 22:52:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 17/17] [POWERPC] Remove get_property
Message-Id: <20070403225222.88e92221.sfr@canb.auug.org.au>
In-Reply-To: <20070403225059.e735b5e4.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403105650.204003b6.sfr@canb.auug.org.au>
	<20070403105748.769f156c.sfr@canb.auug.org.au>
	<20070403105852.7c7bfaa0.sfr@canb.auug.org.au>
	<20070403222406.cf39c459.sfr@canb.auug.org.au>
	<20070403222641.e93cb73b.sfr@canb.auug.org.au>
	<20070403222841.a2c6af1c.sfr@canb.auug.org.au>
	<20070403223000.5d44b2f1.sfr@canb.auug.org.au>
	<20070403223136.6ecdabbd.sfr@canb.auug.org.au>
	<20070403223257.cb8c4d15.sfr@canb.auug.org.au>
	<20070403223535.dd6731d6.sfr@canb.auug.org.au>
	<20070403223738.03386a13.sfr@canb.auug.org.au>
	<20070403223914.35bf04e1.sfr@canb.auug.org.au>
	<20070403224039.913af749.sfr@canb.auug.org.au>
	<20070403224205.807cffe0.sfr@canb.auug.org.au>
	<20070403224340.5533abc9.sfr@canb.auug.org.au>
	<20070403224505.5d5a1495.sfr@canb.auug.org.au>
	<20070403224610.b61c7377.sfr@canb.auug.org.au>
	<20070403224937.f6a07e56.sfr@canb.auug.org.au>
	<20070403225059.e735b5e4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All the uses have been renamed.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/prom.h |    1 -
 include/asm-ppc/prom.h     |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index e73a2b4..12fa0c4 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -169,7 +169,6 @@ extern int machine_is_compatible(const char *compat);
 extern const void *of_get_property(const struct device_node *node,
 				const char *name,
 				int *lenp);
-#define get_property(a, b, c)	of_get_property((a), (b), (c))
 extern void print_properties(struct device_node *node);
 extern int of_n_addr_cells(struct device_node* np);
 extern int of_n_size_cells(struct device_node* np);
diff --git a/include/asm-ppc/prom.h b/include/asm-ppc/prom.h
index 901f7fa..71f4c99 100644
--- a/include/asm-ppc/prom.h
+++ b/include/asm-ppc/prom.h
@@ -35,7 +35,6 @@ extern unsigned long sub_reloc_offset(unsigned long);
 #define machine_is_compatible(x)		0
 #define of_find_compatible_node(f, t, c)	NULL
 #define of_get_property(p, n, l)		NULL
-#define get_property(a, b, c)			of_get_property((a), (b), (c))
 
 #endif /* _PPC_PROM_H */
 #endif /* __KERNEL__ */
-- 
1.5.0.3
