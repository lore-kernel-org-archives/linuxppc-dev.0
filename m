Return-Path: <minchan@kernel.org>
Received: from lgeamrelo13.lge.com (LGEAMRELO13.lge.com [156.147.23.53])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vs2Nq4SHCzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 16:18:19 +1100 (AEDT)
Date: Mon, 27 Mar 2017 14:01:34 +0900
From: Minchan Kim <minchan@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <linux-fbdev@vger.kernel.org>,
 <linux-arch@vger.kernel.org>, <linux-alpha@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
 <linux-mips@linux-mips.org>, <linuxppc-dev@lists.ozlabs.org>,
 <sparclinux@vger.kernel.org>, Matthew Wilcox <mawilcox@microsoft.com>
Subject: Re: [PATCH v3 5/7] zram: Convert to using memset_l
Message-ID: <20170327050134.GA19601@bbox>
References: <20170324161318.18718-1-willy@infradead.org>
 <20170324161318.18718-6-willy@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170324161318.18718-6-willy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 24, 2017 at 09:13:16AM -0700, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> zram was the motivation for creating memset_l().  Minchan Kim sees a 7%
> performance improvement on x86 with 100MB of non-zero deduplicatable
> data:
> 
>         perf stat -r 10 dd if=/dev/zram0 of=/dev/null
> 
> vanilla:        0.232050465 seconds time elapsed ( +-  0.51% )
> memset_l:	0.217219387 seconds time elapsed ( +-  0.07% )
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Tested-by: Minchan Kim <minchan@kernel.org>
Acked-by: Minchan Kim <minchan@kernel.org>

Thanks!
