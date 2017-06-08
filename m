Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjvVb0n9JzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 15:43:50 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v585hmka009896
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jun 2017 01:43:48 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2axxrvvj05-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 01:43:47 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 8 Jun 2017 15:43:40 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v585hbFf15466720
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jun 2017 15:43:37 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v585hSZl002701
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jun 2017 15:43:29 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, clombard@linux.vnet.ibm.com,
 philippe.bergheaud@fr.ibm.com
Subject: Re: [PATCH v2] cxl: Fix error path on bad ioctl
In-Reply-To: <20170606094341.14629-1-fbarrat@linux.vnet.ibm.com>
References: <20170606094341.14629-1-fbarrat@linux.vnet.ibm.com>
Date: Thu, 08 Jun 2017 11:13:27 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87tw3rxce8.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Fred,

Thanks for addressing the review comments.

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> Fix error path if we can't copy user structure on CXL_IOCTL_START_WORK
> ioctl. We shouldn't unlock the context status mutex as it was not
> locked (yet).
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org
> Fixes: 0712dc7e73e5 ("cxl: Fix issues when unmapping contexts")
> ---
> Changelog:
> v2: change sizeof() parameter (Vaibhav)
>     tweak commit message and add 'Fixes:' (mpe)

Reviewed-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
