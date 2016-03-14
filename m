Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qP8VZ5mBQzDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 07:29:25 +1100 (AEDT)
Date: Mon, 14 Mar 2016 13:29:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, hughd@google.com,
 aneesh.kumar@linux.vnet.ibm.com, kirill@shutemov.name,
 n-horiguchi@ah.jp.nec.com, mgorman@techsingularity.net
Subject: Re: [RFC 1/9] mm/hugetlb: Make GENERAL_HUGETLB functions PGD
 implementation aware
Message-Id: <20160314132922.b2297b2b486416e4980741ee@linux-foundation.org>
In-Reply-To: <56E23523.4020201@linux.vnet.ibm.com>
References: <1457525450-4262-1-git-send-email-khandual@linux.vnet.ibm.com>
 <56E23523.4020201@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 11 Mar 2016 08:31:55 +0530 Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:

> On 03/09/2016 05:40 PM, Anshuman Khandual wrote:
> > Currently both the ARCH_WANT_GENERAL_HUGETLB functions 'huge_pte_alloc'
> > and 'huge_pte_offset' dont take into account huge page implementation
> > at the PGD level. With addition of PGD awareness into these functions,
> > more architectures like POWER which also implements huge pages at PGD
> > level (along with PMD level), can use ARCH_WANT_GENERAL_HUGETLB option.
> 
> Hugh/Mel/Naoya/Andrew,
> 
> 	Thoughts/inputs/suggestions ? Does this change looks okay ?

Patches 1, 2 and 3 look OK to me.  Please include them in the powerpc
merge when the patchset is considered ready.
