Return-Path: <iamjoonsoo.kim@lge.com>
Received: from lgemrelse7q.lge.com (LGEMRELSE7Q.lge.com [156.147.1.151])
 by lists.ozlabs.org (Postfix) with ESMTP id 458941A06B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 17:39:32 +1000 (EST)
Date: Thu, 12 Jun 2014 16:43:29 +0900
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v2 09/10] mm, cma: move output param to the end of param
 list
Message-ID: <20140612074329.GC20199@js1304-P5Q-DELUXE>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-10-git-send-email-iamjoonsoo.kim@lge.com>
 <20140612071930.GL12415@bbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140612071930.GL12415@bbox>
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

On Thu, Jun 12, 2014 at 04:19:31PM +0900, Minchan Kim wrote:
> On Thu, Jun 12, 2014 at 12:21:46PM +0900, Joonsoo Kim wrote:
> > Conventionally, we put output param to the end of param list.
> > cma_declare_contiguous() doesn't look like that, so change it.
> 
> If you says "Conventionally", I'd like to suggest one more thing.
> Conventionally, we put 'base' ahead 'size' but dma_contiguous_reserve_area
> is opposite.

Okay. I will do it. :)

Thanks.
