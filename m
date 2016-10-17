Return-Path: <jesper.nilsson@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by lists.ozlabs.org (Postfix) with ESMTP id 3syCc02kK7zDvJY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Oct 2016 20:30:23 +1100 (AEDT)
Date: Mon, 17 Oct 2016 11:23:52 +0200
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: linux-mm@kvack.org, linux-mips@linux-mips.org,
 linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>,
 kvm@vger.kernel.org, linux-sh@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
 x86@kernel.org, Hugh Dickins <hughd@google.com>,
 linux-media@vger.kernel.org, Rik van Riel <riel@redhat.com>,
 intel-gfx@lists.freedesktop.org, adi-buildroot-devel@lists.sourceforge.net,
 ceph-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-cris-kernel@axis.com, Linus Torvalds <torvalds@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH 10/10] mm: replace access_process_vm() write parameter
 with gup_flags
Message-ID: <20161017092352.GH30704@axis.com>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161013002020.3062-11-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161013002020.3062-11-lstoakes@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 13, 2016 at 01:20:20AM +0100, Lorenzo Stoakes wrote:
> This patch removes the write parameter from access_process_vm() and replaces it
> with a gup_flags parameter as use of this function previously _implied_
> FOLL_FORCE, whereas after this patch callers explicitly pass this flag.
> 
> We make this explicit as use of FOLL_FORCE can result in surprising behaviour
> (and hence bugs) within the mm subsystem.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  arch/cris/arch-v32/kernel/ptrace.c |  4 ++--

For the CRIS part:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
