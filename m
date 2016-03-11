Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C3F41A03FE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 14:03:15 +1100 (AEDT)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 11 Mar 2016 08:33:12 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2B32t8P11796978
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 08:32:55 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2B8W5vc000850
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 14:02:07 +0530
Message-ID: <56E2356B.5030600@linux.vnet.ibm.com>
Date: Fri, 11 Mar 2016 08:33:07 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
CC: hughd@google.com, aneesh.kumar@linux.vnet.ibm.com, kirill@shutemov.name,
 n-horiguchi@ah.jp.nec.com, mgorman@techsingularity.net,
 akpm@linux-foundation.org
Subject: Re: [RFC 3/9] mm/gup: Make follow_page_mask function PGD
 implementation aware
References: <1457525450-4262-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1457525450-4262-3-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1457525450-4262-3-git-send-email-khandual@linux.vnet.ibm.com>
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
> Currently the function 'follow_page_mask' does not take into account
> PGD based huge page implementation. This change achieves that and
> makes it complete.

Hugh/Mel/Naoya/Andrew,

	Thoughts/inputs/suggestions ? Does this change look okay ?
