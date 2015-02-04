Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E935F1A0B5B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2015 11:42:38 +1100 (AEDT)
Message-ID: <1423010557.7982.1.camel@ellerman.id.au>
Subject: Re: [PATCH v2 0/4] VPHN parsing fixes
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Date: Wed, 04 Feb 2015 11:42:37 +1100
In-Reply-To: <20150203084640.70b60a7c@bahia.local>
References: <20141217094007.16957.70423.stgit@bahia.local>
 <20150129190353.401248ab@bahia.local>
 <1422931655.4625.6.camel@ellerman.id.au>
 <20150203084640.70b60a7c@bahia.local>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-02-03 at 08:46 +0100, Greg Kurz wrote:
> On Tue, 03 Feb 2015 13:47:35 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > On Thu, 2015-01-29 at 19:03 +0100, Greg Kurz wrote:
> > > On Wed, 17 Dec 2014 10:40:46 +0100
> > > Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:
> > > > Hi,
> > > > 
> > > > This series addresses remarks from Ben and Michael (see individual patches).
> > > > The most notable changes are:
> > > > - the parsing code being pull out into a separate file in patch 3/4. This
> > > >   allows to write userland tests like the one below.
> > > > - a full rewrite of the parsing logic in patch 4/4
> > > > 
> > > 
> > > Ping ?
> > 
> > Sorry, lots of patches needing review.
> 
> Heh, no problem. :) Since this isn't bugfix, I can even repost later, when
> the review pressure is lower.

Yeah if you can repost in ~2 weeks that would be perfect.
 
> > This looks pretty good at a glance, but did you actually write a userspace test
> > for it? If so please send it. I'm happy to rework it into something that can go
> > in selftests.
> > 
> 
> Yes, I wrote the premise of a test program. You can find it in the cover mail of
> this series:
> 
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-December/123601.html
> 
> I'll have a look at selftests.

Thanks. That test looks like a good start, there might be some more cases to
test though?

If you just copy the tools/testing/selftests/powerpc/tm directory and rename to
vhpn, you can probably work out the rest.

cheers
