Return-Path: <mgorman@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B524E1A025B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 21:47:30 +1100 (AEDT)
Date: Thu, 20 Nov 2014 10:47:22 +0000
From: Mel Gorman <mgorman@suse.de>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH 03/10] mm: Convert p[te|md]_numa users to
 p[te|md]_protnone_numa
Message-ID: <20141120104722.GL2725@suse.de>
References: <1416478790-27522-1-git-send-email-mgorman@suse.de>
 <1416478790-27522-4-git-send-email-mgorman@suse.de>
 <063D6719AE5E284EB5DD2968C1650D6D1C9F48CB@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1C9F48CB@AcuExch.aculab.com>
Cc: Rik van Riel <riel@redhat.com>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>, Hugh Dickins <hughd@google.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>, Dave Jones <davej@redhat.com>,
 Sasha Levin <sasha.levin@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 20, 2014 at 10:38:56AM +0000, David Laight wrote:
> From:  Mel Gorman
> > Convert existing users of pte_numa and friends to the new helper. Note
> > that the kernel is broken after this patch is applied until the other
> > page table modifiers are also altered. This patch layout is to make
> > review easier.
> 
> Doesn't that break bisection?
> 

Yes, for automatic NUMA balancing at least. The patch structure is to
to make reviewers job easier and besides, bisecting within patches 2-6
is pointless. If desired, I can collapse patches 2-6 together for the
final submission.

-- 
Mel Gorman
SUSE Labs
