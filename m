Return-Path: <martin.petersen@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x0QsK4ZFjzDr4g
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Jul 2017 07:05:25 +1000 (AEST)
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: tyreld@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, jejb@linux.vnet.ibm.com,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ibmvscsi: constify dev_pm_ops structures.
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <ff2eee2670f773454efdece4f455bb367fff3baa.1498722090.git.arvind.yadav.cs@gmail.com>
Date: Sat, 01 Jul 2017 17:05:06 -0400
In-Reply-To: <ff2eee2670f773454efdece4f455bb367fff3baa.1498722090.git.arvind.yadav.cs@gmail.com>
 (Arvind Yadav's message of "Thu, 29 Jun 2017 13:13:55 +0530")
Message-ID: <yq1bmp3x3zx.fsf@oracle.com>
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

Applied to 4.13/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
