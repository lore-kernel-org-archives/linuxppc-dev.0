Return-Path: <martin.petersen@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1D6m0wmvzDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 11:03:27 +1000 (AEST)
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] cxlflash: Fix to resolve dead-lock during EEH recovery
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1462292801-33954-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1462292854-34014-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Date: Thu, 05 May 2016 21:03:08 -0400
In-Reply-To: <1462292854-34014-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 (Uma Krishnan's message of "Tue, 3 May 2016 11:27:34 -0500")
Message-ID: <yq11t5gxak3.fsf@sermon.lab.mkp.net>
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

Uma> When a cxlflash adapter goes into EEH recovery and multiple
Uma> processes (each having established its own context) are active, the
Uma> EEH recovery can hang if the processes attempt to recover in
Uma> parallel. The symptom logged after a couple of minutes is:

Applied to 4.7/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
