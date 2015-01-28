Return-Path: <Kim.Phillips@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0146.outbound.protection.outlook.com [65.55.169.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F7711A04A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 07:19:46 +1100 (AEDT)
Date: Wed, 28 Jan 2015 14:14:17 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3] powerpc/mm: fix undefined reference to
 `.__kernel_map_pages' on FSL PPC64
Message-ID: <20150128141417.ba2e413fd8ccc8bfd65196e1@freescale.com>
In-Reply-To: <1422415322.32234.3.camel@ellerman.id.au>
References: <20150120140200.aa7ba0eb28d95e456972e178@freescale.com>
 <20150120230150.GA14475@cloud>
 <20150120160738.edfe64806cc8b943beb1dfa0@linux-foundation.org>
 <CAC5umyieZn7ppXkKb45O=C=BF+iv6R_A1Dwfhro=cBJzFeovrA@mail.gmail.com>
 <20150122014550.GA21444@js1304-P5Q-DELUXE>
 <20150122144147.019eedc41f189eac44c3c4cd@freescale.com>
 <CAC5umyiF52cykH2_5TD0yzXb+842gywpe-+XZHEwmrDe0nYCPw@mail.gmail.com>
 <20150122212017.4b7032d52a6c75c06d5b4728@freescale.com>
 <1421987091.24984.13.camel@ellerman.id.au>
 <20150126132222.6477257be204a3332601ef11@freescale.com>
 <1422406862.32234.1.camel@ellerman.id.au>
 <CAAmzW4M3O81wBFeZ+JEVZnjRwMNwXnPKeL62Zz96xe_6a7WZpg@mail.gmail.com>
 <20150127185711.ee819e4b.akpm@linux-foundation.org>
 <1422415322.32234.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Konstantin Khlebnikov <k.khlebnikov@samsung.com>,
 Rik van Riel <riel@redhat.com>, Joonsoo Kim <js1304@gmail.com>,
 Minchan Kim <minchan@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Akinobu Mita <akinobu.mita@gmail.com>, josh@joshtriplett.org,
 Jens Axboe <axboe@fb.com>, Linux Memory
 Management List <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Johannes Weiner <hannes@cmpxchg.org>,
 Scott Wood <scottwood@freescale.com>, Sasha Levin <sasha.levin@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 28 Jan 2015 14:22:02 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> On Tue, 2015-01-27 at 18:57 -0800, Andrew Morton wrote:
> > On Wed, 28 Jan 2015 10:33:59 +0900 Joonsoo Kim <js1304@gmail.com> wrote:
> > 
> > > 2015-01-28 10:01 GMT+09:00 Michael Ellerman <mpe@ellerman.id.au>:
> > > > On Mon, 2015-01-26 at 13:22 -0600, Kim Phillips wrote:
> > > >> arch/powerpc has __kernel_map_pages implementations in mm/pgtable_32.c, and
> > > >
> > > > I'd be happy to take this through the powerpc tree for 3.20, but for this:
> > > >
> > > >> depends on:
> > > >> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > >> Date: Thu, 22 Jan 2015 10:28:58 +0900
> > > >> Subject: [PATCH] mm/debug_pagealloc: fix build failure on ppc and some other archs
> > > >
> > > > I don't have that patch in my tree.
> > > >
> > > > But in what way does this patch depend on that one?
> > > >
> > > > It looks to me like it'd be safe to take this on its own, or am I wrong?
> > > 
> > > Hello,
> > > 
> > > These two patches are merged to Andrew's tree now.
> > 
> > That didn't answer either of Michael's questions ;)
> > 
> > Yes, I think they're independent.  I was holding off on the powerpc

sorry - my bad, they are indeed completely independent.

> > one, waiting to see if it popped up in linux-next via your tree.  I can
> > merge both if you like?
> 
> Right, I didn't think I'd seen it in your tree :)
> 
> I'm happy to take this one, saves a possible merge conflict.

I'm fine either way (I work on linux-next).

Kim
