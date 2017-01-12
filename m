Return-Path: <kishon@ti.com>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzlBb67hHzDqYw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 23:17:27 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 35/37] MAINTAINERS: add PCI EP maintainer
Date: Thu, 12 Jan 2017 15:56:24 +0530
Message-ID: <1484216786-17292-36-git-send-email-kishon@ti.com>
In-Reply-To: <1484216786-17292-1-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add maintainer for the newly introduced PCI EP framework.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 MAINTAINERS |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8672f18..021f676 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9407,6 +9407,15 @@ F:	include/linux/pci*
 F:	arch/x86/pci/
 F:	arch/x86/kernel/quirks.c
 
+PCI EP SUBSYSTEM
+M:	Kishon Vijay Abraham I <kishon@ti.com>
+L:	linux-pci@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
+S:	Supported
+F:	drivers/pci/endpoint/
+F:	drivers/misc/pci_endpoint_test.c
+F:	tools/pci/
+
 PCI DRIVER FOR ALTERA PCIE IP
 M:	Ley Foon Tan <lftan@altera.com>
 L:	rfi@lists.rocketboards.org (moderated for non-subscribers)
-- 
1.7.9.5
