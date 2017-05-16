Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRtwP14qmzDqZY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 20:29:08 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4GASxFb064426
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 06:28:59 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2afw3s7s6d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 06:28:59 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 16 May 2017 20:28:51 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4GASgWJ327954
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 20:28:50 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4GASHRM004274
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 20:28:17 +1000
Subject: Re: [PATCH v2 2/2] powerpc/mm/hugetlb: Add support for 1G huge pages
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 akpm@linux-foundation.org, mpe@ellerman.id.au,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <1494926264-22463-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1494926264-22463-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 16 May 2017 15:57:56 +0530
MIME-Version: 1.0
In-Reply-To: <1494926264-22463-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <04189f80-57fd-b921-20b9-565e1b307270@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/16/2017 02:47 PM, Aneesh Kumar K.V wrote:
> POWER9 supports hugepages of size 2M and 1G in radix MMU mode. This patch
> enables the usage of 1G page size for hugetlbfs. This also update the helper
> such we can do 1G page allocation at runtime.
> 
> We still don't enable 1G page size on DD1 version. This is to avoid doing
> workaround mentioned in commit: 6d3a0379ebdc8 (powerpc/mm: Add
> radix__tlb_flush_pte_p9_dd1()
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Sounds good.

Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
