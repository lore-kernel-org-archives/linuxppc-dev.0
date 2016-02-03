Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2EB411A1D1D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 10:29:08 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 3 Feb 2016 16:29:06 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 7C9C019D8042
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 16:17:03 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u13NT4rU28246240
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Feb 2016 16:29:04 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u13NT3Bu029181
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Feb 2016 16:29:04 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: JBottomley@odin.com
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, brking@linux.vnet.ibm.com, hare@suse.de,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH 0/6] ibmvscsi: code cleanup 
Date: Wed,  3 Feb 2016 17:28:28 -0600
Message-Id: <1454542114-1797-1-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixed up a couple spots that were out of line with the PAPR in regards
to its defined VSCSI protocol. Did away with some magic numbers directly
in the code. Fixed a minor endian issue.

Tyrel Datwyler (6):
  ibmvscsi: Correct values for several viosrp_crq_format enums
  ibmvscsi: Add and use enums for valid CRQ header values
  ibmvscsi: Replace magic values in set_adpater_info() with defines
  ibmvscsi: Use of_root to access OF device tree root node
  ibmvscsi: Remove unsupported host config MAD and sysfs interface
  ibmvscsi: Add endian conversions to sysfs attribute show functions

 drivers/scsi/ibmvscsi/ibmvscsi.c | 117 +++++++--------------------------------
 drivers/scsi/ibmvscsi/viosrp.h   |  20 ++++---
 2 files changed, 30 insertions(+), 107 deletions(-)

-- 
2.5.0
