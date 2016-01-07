Return-Path: <martin.petersen@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 270811A0228
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jan 2016 13:02:09 +1100 (AEDT)
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>
Subject: Re: [PATCH v2 0/6] cxlflash: Miscellaneous fixes and updates
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1450126293-47440-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Date: Wed, 06 Jan 2016 21:01:45 -0500
In-Reply-To: <1450126293-47440-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 (Uma Krishnan's message of "Mon, 14 Dec 2015 14:51:33 -0600")
Message-ID: <yq1ziwignau.fsf@sermon.lab.mkp.net>
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

Uma> This patch set contains miscellaneous fixes and adds support for a
Uma> future IBM CXL adapter. This series is intended for 4.5 and is
Uma> bisectable. Please reference the changelog below for details on
Uma> what has been altered from previous versions of this patch set.

Applied to 4.5/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
