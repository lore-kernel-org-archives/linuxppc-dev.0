Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpMN95qf4zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 18:52:25 +1000 (AEST)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 18 Apr 2016 14:22:22 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3I8qKuC38273138
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 14:22:20 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3I8qGIU013024
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 14:22:19 +0530
Message-ID: <5714A040.9090903@linux.vnet.ibm.com>
Date: Mon, 18 Apr 2016 14:22:16 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
CC: hughd@google.com, dave.hansen@intel.com, aneesh.kumar@linux.vnet.ibm.com,
 kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 mgorman@techsingularity.net, akpm@linux-foundation.org
Subject: Re: [PATCH 00/10] Enable HugeTLB page migration on POWER
References: <1460007464-26726-1-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1460007464-26726-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/07/2016 11:07 AM, Anshuman Khandual wrote:
> This patch series enables HugeTLB page migration on POWER platform.
> This series has some core VM changes (patch 1, 2, 3) and some powerpc
> specific changes (patch 4, 5, 6, 7, 8, 9, 10). Comments, suggestions
> and inputs are welcome.
> 
> Anshuman Khandual (10):
>   mm/mmap: Replace SHM_HUGE_MASK with MAP_HUGE_MASK inside mmap_pgoff
>   mm/hugetlb: Add PGD based implementation awareness
>   mm/hugetlb: Protect follow_huge_(pud|pgd) functions from race

Hugh/Mel/Naoya/Andrew,

Andrew had already reviewed the changes in the first two patches during
the RFC phase and was okay with them. Could you please review the third
patch here as well and let me know your inputs/suggestions. Currently
the third patch has got build failures on SPARC and S390 platforms
(details of which are on the thread with possible fixes). Thank you.



	
