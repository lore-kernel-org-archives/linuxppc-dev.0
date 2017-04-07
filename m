Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzyjz4dBZzDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 21:57:11 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v37BsPxM031990
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Apr 2017 07:57:09 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29p94bm10v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Apr 2017 07:57:08 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 7 Apr 2017 17:27:05 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v37Bth4g8192224
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Apr 2017 17:25:43 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v37BuxYr007521
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Apr 2017 17:27:02 +0530
Subject: Re: [RFC PATCH 5/7] mm/follow_page_mask: Add support for hugetlb pgd
 entries.
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1491314675-15787-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1491314675-15787-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 7 Apr 2017 17:26:59 +0530
MIME-Version: 1.0
In-Reply-To: <1491314675-15787-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <24cc43b2-61c1-87bb-7d9b-c54c4f666a38@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/04/2017 07:34 PM, Aneesh Kumar K.V wrote:
> ppc64 supports pgd hugetlb entries. Add code to handle hugetlb pgd entries to
> follow_page_mask so that ppc64 can switch to it to handle hugetlbe entries.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

This was exactly proposed by two of the patches I had posted
last year with bit more descriptive commit message. Making
follow page mask function aware of PGD based HugeTLB can be
sent separately to core MM. I will send it out to mm list soon
for fresh consideration which will make the series one patch
less.

https://patchwork.ozlabs.org/patch/595033/
https://patchwork.ozlabs.org/patch/595037/
