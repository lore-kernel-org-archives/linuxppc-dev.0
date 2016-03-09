Return-Path: <martin.petersen@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C543A1A009D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 13:21:29 +1100 (AEDT)
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Brian King <brking@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/7] Miscellaneous patches to support cxlflash in PowerVM
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1457128424-53017-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Date: Tue, 08 Mar 2016 21:21:08 -0500
In-Reply-To: <1457128424-53017-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 (Uma Krishnan's message of "Fri, 4 Mar 2016 15:53:44 -0600")
Message-ID: <yq1bn6owfvv.fsf@sermon.lab.mkp.net>
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

Uma> The first 5 patches of this series contain fixes to support the
Uma> cxlflash driver in a PowerVM guest. For the cxlflash driver to be
Uma> functional in a PowerVM guest, a corresponding set of cxl patches
Uma> (currently being upstreamed) is required. Note that this cxlflash
Uma> patch series does not have any build dependencies on the new cxl
Uma> code.

Uma> The sixth patch in the series is a fix to dynamically swap between
Uma> the AFU's internal LUN and an actual LUN detected on the fabric.

Uma> The last patch in the series is a performance enhancement to
Uma> improve throughput with cxlflash driver.

Applied to 4.6/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
