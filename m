Return-Path: <dave.hansen@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id 7FB3A1A0060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 09:57:31 +1100 (AEDT)
Subject: Re: [RFC 5/9] powerpc/mm: Split huge_pte_offset function for BOOK3S
 64K
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1457525450-4262-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1457525450-4262-5-git-send-email-khandual@linux.vnet.ibm.com>
Cc: hughd@google.com, kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 akpm@linux-foundation.org, mgorman@techsingularity.net,
 aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <56E0AA59.4030905@intel.com>
Date: Wed, 9 Mar 2016 14:57:29 -0800
MIME-Version: 1.0
In-Reply-To: <1457525450-4262-5-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/09/2016 04:10 AM, Anshuman Khandual wrote:
> Currently the 'huge_pte_offset' function has only one version for
> all the configuations and platforms. This change splits the function
> into two versions, one for 64K page size based BOOK3S implementation
> and the other one for everything else. This change is also one of the
> prerequisites towards enabling GENERAL_HUGETLB implementation for
> BOOK3S 64K based huge pages.

I think there's a bit of background missing here for random folks on
linux-mm to make sense of these patches.

What is BOOK3S and what does it mean for these patches?  Why is its 64K
page size implementation different than all the others?  Is there a 4K
page size BOOK3S?
