Return-Path: <martin.petersen@oracle.com>
Received: from aserp1050.oracle.com (aserp1050.oracle.com [141.146.126.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yR9Hk5QzYzDr1w
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 23:13:54 +1100 (AEDT)
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v9VCDp3B013035
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 12:13:52 GMT
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] cxlflash: Miscellaneous fixes
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1508967302-54403-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Date: Tue, 31 Oct 2017 08:13:40 -0400
In-Reply-To: <1508967302-54403-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 (Uma Krishnan's message of "Wed, 25 Oct 2017 16:35:02 -0500")
Message-ID: <yq1a807ecqz.fsf@oracle.com>
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

> This patch series contains miscellaneous fixes. All three patches resolve
> minor issues.
>
> This series is intended for 4.15 and is bisectable.

Applied to 4.15/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
