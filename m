Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzF1w3j1nzDr4p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 08:38:44 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5TMcfNX167209
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 18:38:41 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bcv5rpnbf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 18:38:40 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 29 Jun 2017 18:38:39 -0400
Subject: Re: [PATCH] scsi: ibmvscsi: constify dev_pm_ops structures.
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, tyreld@linux.vnet.ibm.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <ff2eee2670f773454efdece4f455bb367fff3baa.1498722090.git.arvind.yadav.cs@gmail.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 29 Jun 2017 15:38:30 -0700
MIME-Version: 1.0
In-Reply-To: <ff2eee2670f773454efdece4f455bb367fff3baa.1498722090.git.arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <a71efdaf-78d0-9a36-c358-3c2719dbcdec@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/29/2017 12:43 AM, Arvind Yadav wrote:
> dev_pm_ops are not supposed to change at runtime. All functions
> working with dev_pm_ops provided by <linux/device.h> work with const
> dev_pm_ops. So mark the non-const structs as const.
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>   17956	   1456	      8	  19420	   4bdc	drivers/scsi/ibmvscsi/ibmvscsi.o
> 
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>   18164	   1264	      8	  19436	   4bec	drivers/scsi/ibmvscsi/ibmvscsi.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
