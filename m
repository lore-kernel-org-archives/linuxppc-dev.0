Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzyH54px7zDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 21:37:21 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v37BY6SH089797
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Apr 2017 07:37:16 -0400
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29p8p6vd03-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Apr 2017 07:37:15 -0400
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 7 Apr 2017 17:07:12 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v37BZn2B9240734
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Apr 2017 17:05:50 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v37Bb76V026719
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Apr 2017 17:07:09 +0530
Subject: Re: [RFC PATCH 4/7] mm/follow_page_mask: Add support for hugepage
 directory entry
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1491314675-15787-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1491314675-15787-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 7 Apr 2017 17:07:02 +0530
MIME-Version: 1.0
In-Reply-To: <1491314675-15787-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <b31d933f-78f6-2f91-62e7-3c2347378e80@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/04/2017 07:34 PM, Aneesh Kumar K.V wrote:
> The defaul implementation prints warning and returns NULL. We will add ppc64
> support in later patches.

The description is not sufficient. The patch makes the entire follow
page mask function aware of hugepd based implementation at PGD, PUD
and PMD level. It also provides default follow_huge_pd() function
which in absence of architecture support prints warning and returns
NULL. The commit description should contain all these details. 
