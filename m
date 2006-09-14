Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D197067B78
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Sep 2006 15:00:42 +1000 (EST)
Date: Thu, 14 Sep 2006 15:00:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iseries: eliminate a couple of warnings
Message-Id: <20060914150036.b182c139.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Copy and paste bug in io.h

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/io.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index 212428d..e235025 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -74,8 +74,8 @@ #define outl(data,addr)		writel(data,((v
  * for older code.
  */
 #define insb(port, buf, ns)	_insb((u8 __iomem *)((port)+pci_io_base), (buf), (ns))
-#define insw(port, buf, ns)	_insw_ns((u8 __iomem *)((port)+pci_io_base), (buf), (ns))
-#define insl(port, buf, nl)	_insl_ns((u8 __iomem *)((port)+pci_io_base), (buf), (nl))
+#define insw(port, buf, ns)	_insw_ns((u16 __iomem *)((port)+pci_io_base), (buf), (ns))
+#define insl(port, buf, nl)	_insl_ns((u32 __iomem *)((port)+pci_io_base), (buf), (nl))
 #define insw_ns(port, buf, ns)	_insw_ns((u16 __iomem *)((port)+pci_io_base), (buf), (ns))
 #define insl_ns(port, buf, nl)	_insl_ns((u32 __iomem *)((port)+pci_io_base), (buf), (nl))
 #else
-- 
1.4.1.1
