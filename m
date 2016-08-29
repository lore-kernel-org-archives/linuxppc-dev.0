Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sNBsQ2PC7zDsWr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 23:12:58 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7TDC8CG055747
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 09:12:56 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2537caeu6p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 09:12:56 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Mon, 29 Aug 2016 23:12:53 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B654D3578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 23:12:51 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7TDCppr64946380
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 23:12:51 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7TDCoGd018017
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 23:12:51 +1000
Date: Mon, 29 Aug 2016 18:42:46 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Mel Gorman <mgorman@techsingularity.net>,
 Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Dave Hansen <dave.hansen@intel.com>, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH V2 2/2] fadump: Register the memory reserved by fadump
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1470330729-6273-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1470330729-6273-2-git-send-email-srikar@linux.vnet.ibm.com>
 <20160804140133.edf295b8263845e50c185fc2@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160804140133.edf295b8263845e50c185fc2@linux-foundation.org>
Message-Id: <20160829131246.GA2505@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Andrew Morton <akpm@linux-foundation.org> [2016-08-04 14:01:33]:

> > Register the memory reserved by fadump, so that the cache sizes are
> > calculated based on the free memory (i.e Total memory - reserved
> > memory).
> 
> Looks harmless enough to me.  I'll schedule the patches for 4.8.  But
> it sounds like they should be backported into older kernels?
> 

Based on the v2 feedback, I just posted a v3 at
http://lkml.kernel.org/r/1472476010-4709-1-git-send-email-srikar@linux.vnet.ibm.com
that tries to reduce the large system hash based on tha reserved memory.
Hence please drop the v2 patches.

-- 
Thanks and Regards
Srikar Dronamraju
