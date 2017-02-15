Return-Path: <jonathan.derrick@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNtCC2WKSzDqH4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 08:46:15 +1100 (AEDT)
From: Jon Derrick <jonathan.derrick@intel.com>
To: 
Cc: Jon Derrick <jonathan.derrick@intel.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Scott Bauer <scott.bauer@intel.com>,
 Rafael Antognolli <rafael.antognolli@intel.com>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCHv4 4/4] MAINTAINERS: Remove powerpc's opal match
Date: Wed, 15 Feb 2017 14:45:57 -0700
Message-Id: <1487195159-12599-5-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1487195159-12599-1-git-send-email-jonathan.derrick@intel.com>
References: <1487195159-12599-1-git-send-email-jonathan.derrick@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PPC's 'opal' match pattern also matches block/sed-opal.c, where it looks
like the 'arch/powerpc' file pattern should be enough to match powerpc
opal code by itself. Remove the opal regex pattern from powerpc.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b983b25..430dd02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7404,7 +7404,6 @@ F:	drivers/pci/hotplug/pnv_php.c
 F:	drivers/pci/hotplug/rpa*
 F:	drivers/scsi/ibmvscsi/
 F:	tools/testing/selftests/powerpc
-N:	opal
 N:	/pmac
 N:	powermac
 N:	powernv
-- 
1.8.3.1
