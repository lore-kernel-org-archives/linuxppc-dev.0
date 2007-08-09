Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 3199BDE0C4
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 05:19:19 +1000 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/11] null_pci_ops: use named structure member initializers
Date: Thu,  9 Aug 2007 14:18:42 -0500
Message-Id: <11866871531627-git-send-email-ntl@pobox.com>
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
 arch/powerpc/kernel/pci_32.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 04a3109..0e2bee4 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -1457,8 +1457,8 @@ null_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 
 static struct pci_ops null_pci_ops =
 {
-	null_read_config,
-	null_write_config
+	.read = null_read_config,
+	.write = null_write_config,
 };
 
 /*
-- 
1.5.2.4
