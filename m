Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 54EE51A0065
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 11:13:08 +1100 (AEDT)
Date: Wed, 3 Feb 2016 11:13:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, David Rientjes
 <rientjes@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, Joonsoo Kim
 <iamjoonsoo.kim@lge.com>, davej@codemonkey.org.uk
Subject: Re: [PATCH v3 2/3] x86: query dynamic DEBUG_PAGEALLOC setting
Message-ID: <20160203111307.5d67c60a@canb.auug.org.au>
In-Reply-To: <20160202150435.60076ce1d603a99c17c08edf@linux-foundation.org>
References: <1453889401-43496-1-git-send-email-borntraeger@de.ibm.com>
 <1453889401-43496-3-git-send-email-borntraeger@de.ibm.com>
 <alpine.DEB.2.10.1601271414180.23510@chino.kir.corp.google.com>
 <56A9E3D1.3090001@de.ibm.com>
 <alpine.DEB.2.10.1601281500160.31035@chino.kir.corp.google.com>
 <alpine.DEB.2.10.1602021351290.4977@chino.kir.corp.google.com>
 <56B12560.4010201@de.ibm.com>
 <20160202142157.1bfc6f81807faaa026957917@linux-foundation.org>
 <56B12FBE.3070909@de.ibm.com>
 <20160202150435.60076ce1d603a99c17c08edf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrew,

On Tue, 2 Feb 2016 15:04:35 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 2 Feb 2016 23:37:50 +0100 Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > 
> > I pushed it on my tree for kbuild testing purposes some days ago. 
> > Will drop so that it can go via mm.  
> 
> There are other patches that I haven't merged because they were already
> in -next.  In fact I think I dropped them because they later popped up
> in -next.
> 
> Some or all of:
> 
> lib-spinlock_debugc-prevent-an-infinite-recursive-cycle-in-spin_dump.patch
> mm-provide-debug_pagealloc_enabled-without-config_debug_pagealloc.patch
> x86-query-dynamic-debug_pagealloc-setting.patch
> s390-query-dynamic-debug_pagealloc-setting.patch
> mm-provide-debug_pagealloc_enabled-without-config_debug_pagealloc.patch
> x86-query-dynamic-debug_pagealloc-setting.patch
> s390-query-dynamic-debug_pagealloc-setting.patch
> 
> So please resend everything which you think is needed.

Christian's tree will be empty in today's linux-next (I just refetched it).

-- 
Cheers,
Stephen Rothwell
