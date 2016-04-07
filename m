Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgbMz0ZcszDq64
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 18:28:47 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id e190so6585205pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Apr 2016 01:28:46 -0700 (PDT)
Subject: Re: [PATCH 01/10] mm/mmap: Replace SHM_HUGE_MASK with MAP_HUGE_MASK
 inside mmap_pgoff
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1460007464-26726-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1460007464-26726-2-git-send-email-khandual@linux.vnet.ibm.com>
Cc: hughd@google.com, kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 akpm@linux-foundation.org, mgorman@techsingularity.net,
 dave.hansen@intel.com, aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <57061A34.6090301@gmail.com>
Date: Thu, 7 Apr 2016 18:28:36 +1000
MIME-Version: 1.0
In-Reply-To: <1460007464-26726-2-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/04/16 15:37, Anshuman Khandual wrote:
> The commit 091d0d55b286 ("shm: fix null pointer deref when userspace
> specifies invalid hugepage size") had replaced MAP_HUGE_MASK with
> SHM_HUGE_MASK. Though both of them contain the same numeric value of
> 0x3f, MAP_HUGE_MASK flag sounds more appropriate than the other one
> in the context. Hence change it back.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Acked-by: Balbir Singh <bsingharora@gmail.com>
