Return-Path: <yuehaibing@huawei.com>
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Kvqv2FtkzF3JS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 20:51:05 +1000 (AEST)
From: YueHaibing <yuehaibing@huawei.com>
To: Russell Currey <ruscur@russell.cc>, Sam Bobroff <sbobroff@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
CC: YueHaibing <yuehaibing@huawei.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-pci@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] PCI/AER: Remove duplicated include from err.c
Date: Wed, 26 Sep 2018 11:00:10 +0000
Message-ID: <1537959610-71713-1-git-send-email-yuehaibing@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pci/pcie/err.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 4da2a62b..773197a 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -12,7 +12,6 @@
 
 #include <linux/pci.h>
 #include <linux/module.h>
-#include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/aer.h>
