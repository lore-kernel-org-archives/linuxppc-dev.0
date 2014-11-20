Return-Path: <sasha.levin@oracle.com>
Received: from aserp1050.oracle.com (aserp1050.oracle.com [141.146.126.70])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 770131A0035
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 09:00:08 +1100 (AEDT)
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 sAKLofKs008737
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 21:50:41 GMT
Message-ID: <546E6221.5000409@oracle.com>
Date: Thu, 20 Nov 2014 16:50:25 -0500
From: Sasha Levin <sasha.levin@oracle.com>
MIME-Version: 1.0
To: Mel Gorman <mgorman@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/10] Replace _PAGE_NUMA with PAGE_NONE protections v2
References: <1416478790-27522-1-git-send-email-mgorman@suse.de>
In-Reply-To: <1416478790-27522-1-git-send-email-mgorman@suse.de>
Content-Type: text/plain; charset=windows-1252
Cc: Rik van Riel <riel@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>, Dave Jones <davej@redhat.com>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/20/2014 05:19 AM, Mel Gorman wrote:
> V1 failed while running under kvm-tools very quickly and a second report
> indicated that it happens on bare metal as well. This version survived
> an overnight run of trinity running under kvm-tools here but verification
> from Sasha would be appreciated.

Hi Mel,

I tried giving it a spin, but it won't apply at all on the latest -mm
tree:

$ git am -3 numa/*
Applying: mm: numa: Do not dereference pmd outside of the lock during NUMA hinting fault
Applying: mm: Add p[te|md] protnone helpers for use by NUMA balancing
Applying: mm: Convert p[te|md]_numa users to p[te|md]_protnone_numa
fatal: sha1 information is lacking or useless (mm/huge_memory.c).
Repository lacks necessary blobs to fall back on 3-way merge.
Cannot fall back to three-way merge.

Did I miss a prerequisite?


Thanks,
Sasha
