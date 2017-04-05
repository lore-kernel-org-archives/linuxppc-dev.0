Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vykj95kwPzDqHj
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 21:52:13 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v35BmpVU080419
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 07:52:01 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29mtpqy5bk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Apr 2017 07:52:01 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 5 Apr 2017 17:21:58 +0530
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v35BptHa12910812
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 17:21:55 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v35Bpsvt014417
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 17:21:55 +0530
Subject: Re: [RFC PATCH 1/7] mm/hugetlb/migration: Use set_huge_pte_at instead
 of set_pte_at
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1491314675-15787-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 5 Apr 2017 17:21:48 +0530
MIME-Version: 1.0
In-Reply-To: <1491314675-15787-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <9153677a-555a-dcee-b10b-ee684c66984e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/04/2017 07:34 PM, Aneesh Kumar K.V wrote:
> The right interface to use to set a hugetlb pte entry is set_huge_pte_at. Use
> that instead of set_pte_at.

This is a generic change, should not mm list be added for this patch.
