Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zr4lk59GpzF1KZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 15:02:26 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1R3xCmK074879
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 23:02:24 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gcwfgcrbf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 23:02:23 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 27 Feb 2018 04:02:22 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 4/4] powerpc/mm/hash64: Increase the VA range
In-Reply-To: <5876ab5b-237f-6e05-62e9-59fb2fe4a8f1@linux.vnet.ibm.com>
References: <20180226140826.11641-1-aneesh.kumar@linux.vnet.ibm.com>
 <20180226140826.11641-5-aneesh.kumar@linux.vnet.ibm.com>
 <5876ab5b-237f-6e05-62e9-59fb2fe4a8f1@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2018 09:32:18 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <874lm39j1x.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com> writes:

> On 02/26/2018 11:08 AM, Aneesh Kumar K.V wrote:
>> ---
>>  arch/powerpc/include/asm/book3s/64/hash-64k.h | 2 +-
>>  arch/powerpc/include/asm/processor.h          | 9 ++++++++-
>>  arch/powerpc/mm/init_64.c                     | 6 ------
>>  arch/powerpc/mm/pgtable_64.c                  | 5 -----
>>  4 files changed, 9 insertions(+), 13 deletions(-)
>
> Hi, Aneesh.
>
> This patch is missing Signed-off-by: line. You're encouraged to run
> checkpatch.pl to inspect your patches.
>
> You may also want to add a brief paragraph in the commit message
> explaining the "why" of this change.
>

Will update.

-aneesh
