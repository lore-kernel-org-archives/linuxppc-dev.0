Return-Path: <martin.petersen@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYsld2wgjzDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 11:55:57 +1100 (AEDT)
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
Subject: Re: [PATCH v2 0/2] Fix regression and performance issue in cxlflash
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1458933920-28788-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Date: Mon, 28 Mar 2016 20:55:35 -0400
In-Reply-To: <1458933920-28788-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 (Uma Krishnan's message of "Fri, 25 Mar 2016 14:25:20 -0500")
Message-ID: <yq1mvpit854.fsf@sermon.lab.mkp.net>
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

Hey Uma,

Uma> This series has a couple of patches in cxlflash.  The first patch
Uma> is critical as it fixes a regression that was introduced by Commit
Uma> 6ded8b3cbd9a ("cxlflash: Unmap problem state area before detaching
Uma> master context") as part of the first SCSI push for v4.6.

Uma> The second patch addresses a performance issue.

main.c |  138 ++++++++++++++++++++++++++++++++++++++++++++---------------------
main.h |    5 --
2 files changed, 97 insertions(+), 46 deletions(-)

This starts to push the limits of what constitutes "a bug fix".

I let it slide because you submitted inside the merge window. Applied to
4.6/scsi-fixes.

-- 
Martin K. Petersen	Oracle Linux Engineering
