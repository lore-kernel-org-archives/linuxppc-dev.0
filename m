Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4RH65cJQzDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 07:37:06 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u73LY5wI031855
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 17:37:03 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24kkahd1eh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Aug 2016 17:37:03 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 3 Aug 2016 17:37:03 -0400
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: james.bottomley@hansenpartnership.com
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, brking@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH 0/2] ibmvfc: FC-TAPE Support
Date: Wed,  3 Aug 2016 16:36:51 -0500
Message-Id: <1470260213-19087-1-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset introduces optional FC-TAPE/FC Class 3 Error Recovery to the
ibmvfc client driver.

Tyrel Datwyler (2):
  ibmvfc: Set READ FCP_XFER_READY DISABLED bit in PRLI
  ibmvfc: add FC Class 3 Error Recovery support

 drivers/scsi/ibmvscsi/ibmvfc.c | 11 +++++++++++
 drivers/scsi/ibmvscsi/ibmvfc.h |  1 +
 2 files changed, 12 insertions(+)

-- 
2.7.4
