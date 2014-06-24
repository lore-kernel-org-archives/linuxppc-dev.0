Return-Path: <iamjoonsoo.kim@lge.com>
Received: from lgeamrelo04.lge.com (lgeamrelo04.lge.com [156.147.1.127])
 by lists.ozlabs.org (Postfix) with ESMTP id 6CC371A0221
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 17:47:43 +1000 (EST)
Date: Tue, 24 Jun 2014 16:52:23 +0900
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 -next 0/9] CMA: generalize CMA reserved area
 management code
Message-ID: <20140624075223.GE4836@js1304-P5Q-DELUXE>
References: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
 <539EB4C7.3080106@samsung.com>
 <20140617012507.GA6825@js1304-P5Q-DELUXE>
 <20140618135144.297c785260f9e2aebead867c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140618135144.297c785260f9e2aebead867c@linux-foundation.org>
Cc: kvm-ppc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>,
 kvm@vger.kernel.org, linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, Michal Nazarewicz <mina86@mina86.com>,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Yanfei <zhangyanfei@cn.fujitsu.com>,
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

On Wed, Jun 18, 2014 at 01:51:44PM -0700, Andrew Morton wrote:
> On Tue, 17 Jun 2014 10:25:07 +0900 Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:
> 
> > > >v2:
> > > >   - Although this patchset looks very different with v1, the end result,
> > > >   that is, mm/cma.c is same with v1's one. So I carry Ack to patch 6-7.
> > > >
> > > >This patchset is based on linux-next 20140610.
> > > 
> > > Thanks for taking care of this. I will test it with my setup and if
> > > everything goes well, I will take it to my -next tree. If any branch
> > > is required for anyone to continue his works on top of those patches,
> > > let me know, I will also prepare it.
> > 
> > Hello,
> > 
> > I'm glad to hear that. :)
> > But, there is one concern. As you already know, I am preparing further
> > patches (Aggressively allocate the pages on CMA reserved memory). It
> > may be highly related to MM branch and also slightly depends on this CMA
> > changes. In this case, what is the best strategy to merge this
> > patchset? IMHO, Anrew's tree is more appropriate branch. If there is
> > no issue in this case, I am willing to develope further patches based
> > on your tree.
> 
> That's probably easier.  Marek, I'll merge these into -mm (and hence
> -next and git://git.kernel.org/pub/scm/linux/kernel/git/mhocko/mm.git)
> and shall hold them pending you review/ack/test/etc, OK?

Hello, Marek.

Could you share your decision about this patchset?

Thanks.
