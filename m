Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 8CD83DDF59
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 05:19:26 +1000 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/11] chrp pci_ops: use named structure member initializers
Date: Thu,  9 Aug 2007 14:18:44 -0500
Message-Id: <1186687161213-git-send-email-ntl@pobox.com>
In-Reply-To: <11866871262306-git-send-email-ntl@pobox.com>
References: <11866871262306-git-send-email-ntl@pobox.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/platforms/chrp/pci.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/pci.c b/arch/powerpc/platforms/chrp/pci.c
index 28d1647..0c6dba9 100644
--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -86,8 +86,8 @@ int gg2_write_config(struct pci_bus *bus, unsigned int devfn, int off,
 
 static struct pci_ops gg2_pci_ops =
 {
-	gg2_read_config,
-	gg2_write_config
+	.read = gg2_read_config,
+	.write = gg2_write_config,
 };
 
 /*
@@ -124,8 +124,8 @@ int rtas_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 
 static struct pci_ops rtas_pci_ops =
 {
-	rtas_read_config,
-	rtas_write_config
+	.read = rtas_read_config,
+	.write = rtas_write_config,
 };
 
 volatile struct Hydra __iomem *Hydra = NULL;
-- 
1.5.2.4
