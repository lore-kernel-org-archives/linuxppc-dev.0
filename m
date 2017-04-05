Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyqNp0t6RzDqHH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 01:23:21 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v35FJH11007230
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 11:23:17 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29n22fvesr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Apr 2017 11:23:17 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 5 Apr 2017 11:23:16 -0400
Subject: Re: [RFC PATCH 1/7] mm/hugetlb/migration: Use set_huge_pte_at instead
 of set_pte_at
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
References: <1491314675-15787-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <9153677a-555a-dcee-b10b-ee684c66984e@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 5 Apr 2017 20:53:08 +0530
MIME-Version: 1.0
In-Reply-To: <9153677a-555a-dcee-b10b-ee684c66984e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <343c6f89-486a-af0c-15d5-a60abb36c24c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 05 April 2017 05:21 PM, Anshuman Khandual wrote:
> On 04/04/2017 07:34 PM, Aneesh Kumar K.V wrote:
>> The right interface to use to set a hugetlb pte entry is set_huge_pte_at. Use
>> that instead of set_pte_at.
>
> This is a generic change, should not mm list be added for this patch.
>


yes to all the patches. Look for my reply to patch 1 where I mentioned 
the plan for linux-mm


https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-April/156225.html

-aneesh
