Return-Path: <kirill@shutemov.name>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y64dK6t39zDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 03:44:52 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id b189so6020677wmd.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Oct 2017 09:44:52 -0700 (PDT)
Date: Tue, 3 Oct 2017 19:44:48 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Zi Yan <zi.yan@sent.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Zi Yan <zi.yan@cs.rutgers.edu>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] mm: remove unnecessary WARN_ONCE in
 page_vma_mapped_walk().
Message-ID: <20171003164448.gasvu5iu3xaoscgo@node.shutemov.name>
References: <20171003142606.12324-1-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171003142606.12324-1-zi.yan@sent.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 03, 2017 at 10:26:06AM -0400, Zi Yan wrote:
> From: Zi Yan <zi.yan@cs.rutgers.edu>
> 
> A non present pmd entry can appear after pmd_lock is taken in
> page_vma_mapped_walk(), even if THP migration is not enabled.
> The WARN_ONCE is unnecessary.
> 
> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> Reported-and-tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Signed-off-by: Zi Yan <zi.yan@cs.rutgers.edu>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
