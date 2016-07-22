Return-Path: <martin.petersen@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rx29D30LYzDqTC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jul 2016 06:21:19 +1000 (AEST)
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
Subject: Re: [PATCH 0/2] cxlflash: Regression patch and updating Maintainers
 list
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1469133772-14953-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Date: Fri, 22 Jul 2016 16:21:10 -0400
In-Reply-To: <1469133772-14953-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 (Uma Krishnan's message of "Thu, 21 Jul 2016 15:42:52 -0500")
Message-ID: <yq1bn1pbf0p.fsf@sermon.lab.mkp.net>
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

Uma> First patch in this set fixes a regression that was casued by the
Uma> Commit 704c4b0ddc03 ("cxlflash: Shutdown notify support for CXL
Uma> Flash cards"), which is currently staged for 4.8 in next/master.
Uma> Second patch updates the Maintainers list for cxlflash driver.

Uma> This series is intended for 4.8 and is bisectable. These patches
Uma> are cut against next/master that contains the original commit.

Applied to 4.8/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
