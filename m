Return-Path: <martin.petersen@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVwBc3K0MzDrpW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 21:36:07 +1000 (AEST)
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/6] cxlflash: Miscellaneous fixes
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1472848612-64888-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Date: Fri, 09 Sep 2016 07:35:58 -0400
In-Reply-To: <1472848612-64888-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 (Uma Krishnan's message of "Fri, 2 Sep 2016 15:36:52 -0500")
Message-ID: <yq1inu5fgpt.fsf@sermon.lab.mkp.net>
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

>>>>> "Uma" == Uma Krishnan <ukrishn@linux.vnet.ibm.com> writes:

Uma> This patch set contains miscellaneous fixes in the device cleanup
Uma> and EEH recovery paths. One of the patches simplifies the WWPN
Uma> assignment routine.

Uma> There are a couple of fixes that resolve regressions introduced by
Uma> Commit 704c4b0ddc03 ("cxlflash: Shutdown notify support for CXL
Uma> Flash cards") and Commit 888baf069f49 ("scsi: cxlflash: Add kref to
Uma> context")

Applied patches 1 and 2 to 4.9/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
