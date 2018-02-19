Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlRBh0YcVzDr9G
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 01:36:11 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1JEYu5H031645
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 09:36:09 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g7yv8swsc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 09:36:08 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Mon, 19 Feb 2018 14:36:03 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH V5] cxl: Fix timebase synchronization status on P9
In-Reply-To: <1519050491-15326-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1519050491-15326-1-git-send-email-clombard@linux.vnet.ibm.com>
Date: Mon, 19 Feb 2018 20:05:56 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87tvudgi7n.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Lombard <clombard@linux.vnet.ibm.com> writes:

> The PSL Timebase register is updated by the PSL to maintain the
> timebase.
> On P9, the Timebase value is only provided by the CAPP as received
> the last time a timebase request was performed.
> The timebase requests are initiated through the adapter configuration or
> application registers.
> The specific sysfs entry "/sys/class/cxl/cardxx/psl_timebase_synced" is
> now dynamically updated according the content of the PSL Timebase
> register.
>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
>
> ---
> This patch applies on top of this patch:
>  http://patchwork.ozlabs.org/patch/873663/

LGTM. Thanks for updating the patch Christophe.

Reviewed-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
