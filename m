Return-Path: <martin.petersen@oracle.com>
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFzGD1RcnzDqrx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 15:10:59 +1100 (AEDT)
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/6] cxlflash: Miscellaneous patches
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1515020002-43551-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Date: Mon, 08 Jan 2018 22:07:51 -0500
In-Reply-To: <1515020002-43551-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 (Uma Krishnan's message of "Wed, 3 Jan 2018 16:53:22 -0600")
Message-ID: <yq1o9m3ohko.fsf@oracle.com>
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


Uma,

> This patch series contains miscellaneous fixes. The first patch fixes
> a bug while the rest improve the code structure and prepare the code
> for future enhancements.

Added stable tag to first patch and applied series to
4.16/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
