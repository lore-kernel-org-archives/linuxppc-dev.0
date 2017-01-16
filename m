Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v23t60LnxzDqSV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 17:56:13 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0G6s3Vf090035
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 01:56:11 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 280bepw2bk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 01:56:11 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 16 Jan 2017 16:56:09 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 054F52CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 17:56:07 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0G6u65k36503624
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 17:56:06 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0G6u62O022378
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 17:56:06 +1100
Subject: Re: [PATCH] powerpc/mm/hugetlb: Don't panic if we don't find the
 default huge page size
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Chris Smart <csmart@ozlabs.au.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
References: <20161213140411.20633-1-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 16 Jan 2017 12:25:53 +0530
MIME-Version: 1.0
In-Reply-To: <20161213140411.20633-1-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <4f38a92d-353f-d505-43c3-a2d752d22657@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/13/2016 07:34 PM, Aneesh Kumar K.V wrote:
> generic hugetlbfs can handle that condition correctly. With HPAGE_SHIFT = 0

Need to add some context here. "That condition" refers to something without
first mentioning it.

> we get
> [0.241333] hugetlbfs: disabling because there are no supported hugepage sizes
> 
> bash-4.2# echo 30 > /proc/sys/vm/nr_hugepages
> bash: echo: write error: Operation not supported
> 
> Fixes: "powerpc: get hugetlbpage handling more generic"

Dont we need the commit SHA for the "Fixes" header ?
