Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 16CB31A0406
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 14:03:33 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 11 Mar 2016 13:03:31 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7E8732CE805A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 14:03:23 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2B33F511638736
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 14:03:23 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2B32oxE020040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 14:02:51 +1100
Message-ID: <56E23547.2040303@linux.vnet.ibm.com>
Date: Fri, 11 Mar 2016 08:32:31 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
CC: hughd@google.com, aneesh.kumar@linux.vnet.ibm.com, kirill@shutemov.name,
 n-horiguchi@ah.jp.nec.com, mgorman@techsingularity.net,
 akpm@linux-foundation.org
Subject: Re: [RFC 2/9] mm/hugetlb: Add follow_huge_pgd function
References: <1457525450-4262-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1457525450-4262-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1457525450-4262-2-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/09/2016 05:40 PM, Anshuman Khandual wrote:
> This just adds 'follow_huge_pgd' function which is will be used
> later in this series to make 'follow_page_mask' function aware
> of PGD based huge page implementation.

Hugh/Mel/Naoya/Andrew,

	Thoughts/inputs/suggestions ? Does this change looks okay ?
