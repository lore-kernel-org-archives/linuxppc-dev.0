Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzltp4vxczDqHW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 13:49:06 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v373mxgD090819
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Apr 2017 23:48:59 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29nxknu1hy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Apr 2017 23:48:59 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 7 Apr 2017 13:48:56 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v373mkfo48627902
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Apr 2017 13:48:54 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v373mL9f020442
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Apr 2017 13:48:22 +1000
Subject: Re: [PATCH V3] powerpc/hugetlb: Add ABI defines for supported HugeTLB
 page sizes
To: LEROY Christophe <christophe.leroy@c-s.fr>
References: <87pogrtjns.fsf@concordia.ellerman.id.au>
 <20170405112007.17390-1-khandual@linux.vnet.ibm.com>
 <20170406210349.Horde.IjWAXy6PGr_tNkSos87TqQ3@messagerie.c-s.fr>
Cc: aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 7 Apr 2017 09:17:59 +0530
MIME-Version: 1.0
In-Reply-To: <20170406210349.Horde.IjWAXy6PGr_tNkSos87TqQ3@messagerie.c-s.fr>
Content-Type: text/plain; charset=utf-8
Message-Id: <5fb76b92-2988-1207-2bed-814a96e6a51a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/07/2017 12:33 AM, LEROY Christophe wrote:
> Hi
> 
> Anshuman Khandual <khandual@linux.vnet.ibm.com> a écrit :
> 
>> This just adds user space exported ABI definitions for 2MB, 16MB, 1GB,
>> 16GB non default huge page sizes to be used with mmap() system call.
> 
> Why not add all possible huge page sizes ?
> For instance the 8xx (only) supports 512k and 8M hugepages

Sure, can do that.
