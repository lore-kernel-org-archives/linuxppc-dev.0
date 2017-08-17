Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY6xy18DNzDrCv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 23:48:54 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 83so9991969pgb.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 06:48:54 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: tyreld@linux.vnet.ibm.com, paulus@samba.org, jejb@linux.vnet.ibm.com,
 martin.petersen@oracle.com, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] constify scsi vio_device_id
Date: Thu, 17 Aug 2017 19:18:43 +0530
Message-Id: <1502977723-3207-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

vio_device_id are not supposed to change at runtime. All functions
working with vio_device_id provided by <asm/vio.h> work with
const vio_device_id. So mark the non-const structs as const.

Arvind Yadav (3):
  [PATCH 1/3] scsi: ibmvfc: constify vio_device_id
  [PATCH 2/3] scsi: ibmvscsi: constify vio_device_id
  [PATCH 3/3] scsi: ibmvscsi_tgt: constify vio_device_id

 drivers/scsi/ibmvscsi/ibmvfc.c           | 2 +-
 drivers/scsi/ibmvscsi/ibmvscsi.c         | 2 +-
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4
