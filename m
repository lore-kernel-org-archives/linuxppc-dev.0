Return-Path: <iamjoonsoo.kim@lge.com>
Received: from lgemrelse6q.lge.com (LGEMRELSE6Q.lge.com [156.147.1.121])
 by lists.ozlabs.org (Postfix) with ESMTP id 4B0C21A00EF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jun 2014 15:14:22 +1000 (EST)
Date: Mon, 16 Jun 2014 14:18:31 +0900
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH v2 01/10] DMA, CMA: clean-up log message
Message-ID: <20140616051830.GA23210@js1304-P5Q-DELUXE>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-2-git-send-email-iamjoonsoo.kim@lge.com>
 <87y4x2pwnk.fsf@linux.vnet.ibm.com>
 <20140612055358.GA30128@js1304-P5Q-DELUXE>
 <xa1toaxyjym3.fsf@mina86.com> <xa1tegyujvxv.fsf@mina86.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <xa1tegyujvxv.fsf@mina86.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, kvm@vger.kernel.org,
 linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
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

On Thu, Jun 12, 2014 at 11:53:16AM +0200, Michal Nazarewicz wrote:
> On Thu, Jun 12 2014, Michal Nazarewicz <mina86@mina86.com> wrote:
> > I used “function(arg1, arg2, …)” at the *beginning* of functions when
> > the arguments passed to the function were included in the message.  In
> > all other cases I left it at just “function:” (or just no additional
> > prefix).  IMO that's a reasonable strategy.
> 
> At closer inspection, I realised drivers/base/dma-contiguous.c is
> Marek's code, but the above I think is still reasonable thing to do, so
> I'd rather standardise on having “function(…)” only at the beginning of
> a function.  Just my 0.02 CHF.

Hello,

Now, I realize that these changes aren't needed in this patchset, so I
simplify this patch just to remove redundant 'CMA' prefix. Other things
can be done after merging if we need.

Thanks.
