Return-Path: <martin.petersen@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x0QpY6xnhzDr4g
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Jul 2017 07:03:01 +1000 (AEST)
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Hannes Reinecke <hare@suse.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/3] cxlflash: Minor fix and EH refactoring
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1498669929-39684-1-git-send-email-mrochs@linux.vnet.ibm.com>
Date: Sat, 01 Jul 2017 17:02:44 -0400
In-Reply-To: <1498669929-39684-1-git-send-email-mrochs@linux.vnet.ibm.com>
 (Matthew R. Ochs's message of "Wed, 28 Jun 2017 12:12:09 -0500")
Message-ID: <yq1fuefx43v.fsf@oracle.com>
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


Matthew,

> This small series fixes a recently injected double free and also
> includes two patches to refactor the host and reset handlers to ease
> the burden of making this driver compatible with an updated SCSI EH
> framework.

Applied to 4.13/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
