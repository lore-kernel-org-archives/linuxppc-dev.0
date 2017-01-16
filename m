Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2KZm2knhzDqSW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 04:13:51 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0GH8nEr076062
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 12:13:47 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2810y33utb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 12:13:47 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 16 Jan 2017 10:13:46 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au,
 Chris Smart <csmart@ozlabs.au.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm/hugetlb: Don't panic if we don't find the
 default huge page size
In-Reply-To: <4f38a92d-353f-d505-43c3-a2d752d22657@linux.vnet.ibm.com>
References: <20161213140411.20633-1-aneesh.kumar@linux.vnet.ibm.com>
 <4f38a92d-353f-d505-43c3-a2d752d22657@linux.vnet.ibm.com>
Date: Mon, 16 Jan 2017 22:12:32 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87ziirx8g7.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:

> On 12/13/2016 07:34 PM, Aneesh Kumar K.V wrote:
>> generic hugetlbfs can handle that condition correctly. With HPAGE_SHIFT = 0
>
> Need to add some context here. "That condition" refers to something without
> first mentioning it.

It is the conditinal statement that gets removed as part of this patch.
The next line also explains what the generic code does for that condition.
>
>> we get
>> [0.241333] hugetlbfs: disabling because there are no supported hugepage sizes
>> 
>> bash-4.2# echo 30 > /proc/sys/vm/nr_hugepages
>> bash: echo: write error: Operation not supported
>> 
>> Fixes: "powerpc: get hugetlbpage handling more generic"
>
> Dont we need the commit SHA for the "Fixes" header ?

When I wrote the patch, the commit was not upstream. Hence i didn't had
an SHA1 to put there.

-aneesh
