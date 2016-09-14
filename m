Return-Path: <martin.petersen@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZ6vD0Cw6zDsW5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 02:48:55 +1000 (AEST)
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
Subject: Re: [PATCH 3/6] cxlflash: Fix to avoid EEH and host reset collisions
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1472848612-64888-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1472848770-65034-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Date: Wed, 14 Sep 2016 12:48:44 -0400
In-Reply-To: <1472848770-65034-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 (Uma Krishnan's message of "Fri, 2 Sep 2016 15:39:30 -0500")
Message-ID: <yq1sht2mnpv.fsf@sermon.lab.mkp.net>
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

Applied patches 3 through 6 to 4.9/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
