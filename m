Return-Path: <martin.petersen@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqfcW6yqxzDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 12:22:51 +1000 (AEST)
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com,
 mrochs@linux.vnet.ibm.com, linux-scsi@vger.kernel.org,
 manoj@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com,
 fbarrat@linux.vnet.ibm.com
Subject: Re: [PATCH] cxl: remove dead Kconfig options
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1467616334-20977-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <yq1k2gpm0y0.fsf@sermon.lab.mkp.net>
 <984bdc4c-1522-f166-c4c2-4f7e5b08909a@au1.ibm.com>
Date: Wed, 13 Jul 2016 22:22:41 -0400
In-Reply-To: <984bdc4c-1522-f166-c4c2-4f7e5b08909a@au1.ibm.com> (Andrew
 Donnellan's message of "Thu, 14 Jul 2016 12:05:08 +1000")
Message-ID: <yq1bn21m00e.fsf@sermon.lab.mkp.net>
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

>>>>> "Andrew" == Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:

>> This patch straddles a few subsystems. Did you intend for me to queue
>> it through SCSI?

Andrew> Sorry for not stating explicitly - I'd like this taken through
Andrew> powerpc as the cxlflash change is incidental to the cxl changes.

No problem.

-- 
Martin K. Petersen	Oracle Linux Engineering
