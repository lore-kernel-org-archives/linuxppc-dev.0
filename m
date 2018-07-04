Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LQ2R4Rl8zF0ZD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 01:31:39 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w64FSlEJ081489
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jul 2018 11:31:37 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k0wbx9av1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jul 2018 11:31:37 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 4 Jul 2018 16:31:35 +0100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [bug report] cxl: Prevent adapter reset if an active context
 exists
In-Reply-To: <20180704144050.mjex2gg7hsarhc6x@kili.mountain>
References: <20180704144050.mjex2gg7hsarhc6x@kili.mountain>
Date: Wed, 04 Jul 2018 21:01:30 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87o9fnnhkd.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Dan Carpenter <dan.carpenter@oracle.com> writes:

> The patch 70b565bbdb91: "cxl: Prevent adapter reset if an active
> context exists" from Oct 14, 2016, leads to the following static
> checker warning:
>
> 	drivers/misc/cxl/main.c:290 cxl_adapter_context_get()
> 	warn: 'atomic_inc_unless_negative(&adapter->contexts_num)' is unsigned
>
Thanks for reporting this. I have sent out a patch to fix this at
http://patchwork.ozlabs.org/patch/939426/

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
