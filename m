Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E40B1A010A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 07:01:48 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 9 Mar 2016 13:01:27 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id C9B913E40044
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 13:01:23 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u29K1NQA41287850
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 13:01:23 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u29K1MgQ032367
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 13:01:23 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hughd@google.com, kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 akpm@linux-foundation.org, mgorman@techsingularity.net, mpe@ellerman.id.au
Subject: Re: [RFC 9/9] selfttest/powerpc: Add memory page migration tests
In-Reply-To: <1457525450-4262-9-git-send-email-khandual@linux.vnet.ibm.com>
References: <1457525450-4262-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1457525450-4262-9-git-send-email-khandual@linux.vnet.ibm.com>
Date: Thu, 10 Mar 2016 01:31:13 +0530
Message-ID: <8737rz1kvq.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:

> [ text/plain ]
> This adds two tests for memory page migration. One for normal page
> migration which works for both 4K or 64K base page size kernel and
> the other one is for huge page migration which works only on 64K
> base page sized 16MB huge page implemention at the PMD level.
>

can you also add the test in this commit
e66f17ff717 ("mm/hugetlb: take page table lock in follow_huge_pmd()")

> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---

-aneesh
