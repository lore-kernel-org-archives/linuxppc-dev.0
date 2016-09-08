Return-Path: <weiyj.lk@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVNst4tMYzDrgZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 01:04:50 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id x24so2621953pfa.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Sep 2016 08:04:50 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-scsi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH -next] scsi: ibmvfc: fix typo in parameter description
Date: Thu,  8 Sep 2016 15:04:41 +0000
Message-Id: <1473347081-25953-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix typo in parameter description.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 6b92169..56b9f45 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -88,7 +88,7 @@ module_param_named(log_level, log_level, uint, 0);
 MODULE_PARM_DESC(log_level, "Set to 0 - 4 for increasing verbosity of device driver. "
 		 "[Default=" __stringify(IBMVFC_DEFAULT_LOG_LEVEL) "]");
 module_param_named(cls3_error, cls3_error, uint, 0);
-MODULE_PARM_DESC(log_level, "Enable FC Class 3 Error Recovery. "
+MODULE_PARM_DESC(cls3_error, "Enable FC Class 3 Error Recovery. "
 		 "[Default=" __stringify(IBMVFC_CLS3_ERROR) "]");
 
 static const struct {
