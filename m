Return-Path: <minchan@kernel.org>
Received: from lgemrelse6q.lge.com (LGEMRELSE6Q.lge.com [156.147.1.121])
 by lists.ozlabs.org (Postfix) with ESMTP id 31B061A02CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 17:16:06 +1000 (EST)
Date: Thu, 12 Jun 2014 16:16:15 +0900
From: Minchan Kim <minchan@kernel.org>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 08/10] mm, cma: clean-up cma allocation error path
Message-ID: <20140612071615.GK12415@bbox>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-9-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402543307-29800-9-git-send-email-iamjoonsoo.kim@lge.com>
Cc: kvm-ppc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>,
 kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, Michal Nazarewicz <mina86@mina86.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 12, 2014 at 12:21:45PM +0900, Joonsoo Kim wrote:
> We can remove one call sites for clear_cma_bitmap() if we first
> call it before checking error number.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Acked-by: Minchan Kim <minchan@kernel.org>

-- 
Kind regards,
Minchan Kim
