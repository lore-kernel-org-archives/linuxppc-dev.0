Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1A86E6889F
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Dec 2005 08:53:50 +1100 (EST)
Date: Mon, 19 Dec 2005 15:49:07 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.44.0512191548370.5578-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix compile problem in pci.c for ppc32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pci_address_to_pio is missing a closing curly brace

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit a86f866f7b31e01c729ee7498228c547a51d8514
tree 7cc7df7f28735a34618d450cc46bfd3c86d8725b
parent c211d7347a735eb5d5996433f3eef7159c3fe41a
author Kumar Gala <galak@kernel.crashing.org> Mon, 19 Dec 2005 15:52:42 -0600
committer Kumar Gala <galak@kernel.crashing.org> Mon, 19 Dec 2005 15:52:42 -0600

 arch/ppc/kernel/pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/kernel/pci.c b/arch/ppc/kernel/pci.c
index 664af8b..7d4c0e3 100644
--- a/arch/ppc/kernel/pci.c
+++ b/arch/ppc/kernel/pci.c
@@ -1823,7 +1823,7 @@ unsigned long pci_address_to_pio(phys_ad
 			unsigned long base =
 				(unsigned long)hose->io_base_virt - _IO_BASE;
 			return base + (address - hose->io_base_phys);
-
+		}
 	}
 	return (unsigned int)-1;
 }
