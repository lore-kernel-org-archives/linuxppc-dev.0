Return-Path: <martin.petersen@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x0Qsv1wdvzDr8Q
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Jul 2017 07:05:55 +1000 (AEST)
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: tyreld@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, jejb@linux.vnet.ibm.com,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ibmvfc: constify dev_pm_ops structures.
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <c0ec5db7e2c3313cb7b417e76330520fd2b6136c.1498722828.git.arvind.yadav.cs@gmail.com>
Date: Sat, 01 Jul 2017 17:05:40 -0400
In-Reply-To: <c0ec5db7e2c3313cb7b417e76330520fd2b6136c.1498722828.git.arvind.yadav.cs@gmail.com>
 (Arvind Yadav's message of "Thu, 29 Jun 2017 13:24:41 +0530")
Message-ID: <yq17ezrx3yz.fsf@oracle.com>
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


Arvind,

> dev_pm_ops are not supposed to change at runtime. All functions
> working with dev_pm_ops provided by <linux/device.h> work with const
> dev_pm_ops. So mark the non-const structs as const.

Applied to 4.13/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
