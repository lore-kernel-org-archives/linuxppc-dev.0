Return-Path: <agordeev@dhcp-26-207.brq.redhat.com>
Received: from dhcp-26-207.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A6E572C1331
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 03:45:24 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 17/77] cciss: Update a misleading comment on interrupt
 usage
Date: Wed,  2 Oct 2013 12:48:33 +0200
Message-Id: <3607cede809d07e1d1d6548a5f249d1ac2f9094c.1380703262.git.agordeev@redhat.com>
In-Reply-To: <cover.1380703262.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
Cc: linux-mips@linux-mips.org, "VMware, Inc." <pv-drivers@vmware.com>,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 stable@vger.kernel.org, linux-s390@vger.kernel.org,
 Andy King <acking@vmware.com>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, x86@kernel.org,
 Alexander Gordeev <agordeev@redhat.com>, linux-pci@vger.kernel.org,
 iss_storagedev@hp.com, linux-driver@qlogic.com, Tejun Heo <tj@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jon Mason <jon.mason@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 e1000-devel@lists.sourceforge.net, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 drivers/block/cciss.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index 80068a0..bf11540 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -4103,7 +4103,10 @@ static void cciss_interrupt_mode(ctlr_info_t *h)
 	}
 default_int_mode:
 #endif				/* CONFIG_PCI_MSI */
-	/* if we get here we're going to use the default interrupt mode */
+	/*
+	 * If we get here we're going to use either the
+	 * default interrupt mode or single MSI mode
+	 */
 	h->intr[h->intr_mode] = h->pdev->irq;
 	return;
 }
-- 
1.7.7.6
