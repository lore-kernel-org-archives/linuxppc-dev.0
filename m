Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 8C72CDDF5C
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 05:18:59 +1000 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/11] celleb_fake_pci_ops: use named structure member
	initializers
Date: Thu,  9 Aug 2007 14:18:37 -0500
Message-Id: <11866871331871-git-send-email-ntl@pobox.com>
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
 arch/powerpc/platforms/celleb/pci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/celleb/pci.c b/arch/powerpc/platforms/celleb/pci.c
index e9ac19c..de8038b 100644
--- a/arch/powerpc/platforms/celleb/pci.c
+++ b/arch/powerpc/platforms/celleb/pci.c
@@ -242,8 +242,8 @@ static int celleb_fake_pci_write_config(struct pci_bus *bus,
 }
 
 static struct pci_ops celleb_fake_pci_ops = {
-	celleb_fake_pci_read_config,
-	celleb_fake_pci_write_config
+	.read = celleb_fake_pci_read_config,
+	.write = celleb_fake_pci_write_config,
 };
 
 static inline void celleb_setup_pci_base_addrs(struct pci_controller *hose,
-- 
1.5.2.4
