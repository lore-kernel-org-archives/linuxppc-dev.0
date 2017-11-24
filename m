Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjxDx3vVxzDrM5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Nov 2017 00:02:40 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAOCxENZ067131
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 08:02:37 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2eehmwxdcc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 08:02:36 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Fri, 24 Nov 2017 13:02:33 -0000
Subject: Re: [PATCH] cxl: Add support for ASB_Notify on POWER9
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: christophe lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
Date: Sat, 25 Nov 2017 00:02:27 +1100
In-Reply-To: <49cd46e7-c13e-c82c-404c-2c9e989b9774@linux.vnet.ibm.com>
References: <1511435132-24020-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1511469668.2466.48.camel@au1.ibm.com>
 <49cd46e7-c13e-c82c-404c-2c9e989b9774@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1511528547.2466.52.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-11-24 at 11:14 +0100, christophe lombard wrote:
> To my knowledge, there is no property (or similar), somewhere, that
> indicating that the TIDR is supported or not.
> For the time being, if I am not wrong, the only check we have, is
> this condition in the function set_thread_tidr(struct task_struct *t):
> 
>         if (!cpu_has_feature(CPU_FTR_ARCH_300))
>                 return -EINVAL;
> 
> 
> Christophe

Then we need to fix that

Ben.
