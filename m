Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B4BA1A0356
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 14:03:10 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 11 Mar 2016 13:03:08 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B9E242BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 14:02:47 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2B32dA352428972
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 14:02:47 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2B32EJL018510
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 14:02:15 +1100
Message-ID: <56E23523.4020201@linux.vnet.ibm.com>
Date: Fri, 11 Mar 2016 08:31:55 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
CC: hughd@google.com, aneesh.kumar@linux.vnet.ibm.com, kirill@shutemov.name,
 n-horiguchi@ah.jp.nec.com, mgorman@techsingularity.net,
 akpm@linux-foundation.org
Subject: Re: [RFC 1/9] mm/hugetlb: Make GENERAL_HUGETLB functions PGD
 implementation aware
References: <1457525450-4262-1-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1457525450-4262-1-git-send-email-khandual@linux.vnet.ibm.com>
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
> Currently both the ARCH_WANT_GENERAL_HUGETLB functions 'huge_pte_alloc'
> and 'huge_pte_offset' dont take into account huge page implementation
> at the PGD level. With addition of PGD awareness into these functions,
> more architectures like POWER which also implements huge pages at PGD
> level (along with PMD level), can use ARCH_WANT_GENERAL_HUGETLB option.

Hugh/Mel/Naoya/Andrew,

	Thoughts/inputs/suggestions ? Does this change looks okay ?
