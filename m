Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmdV20tbCzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 23:21:30 +1000 (AEST)
Message-ID: <1460726483.4754.0.camel@ellerman.id.au>
Subject: Re: [PATCH 0/5] Live patching for powerpc
From: Michael Ellerman <mpe@ellerman.id.au>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Torsten Duwe <duwe@lst.de>, Jiri Kosina <jikos@kernel.org>, Miroslav
 Benes <mbenes@suse.cz>, linuxppc-dev@ozlabs.org, bsingharora@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com,  pmladek@suse.com, jeyu@redhat.com,
 live-patching@vger.kernel.org
Date: Fri, 15 Apr 2016 23:21:23 +1000
In-Reply-To: <20160415125939.lrft3nawlzuozjkb@treble>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
 <alpine.LNX.2.00.1604131457180.16586@pobox.suse.cz>
 <alpine.LNX.2.00.1604131508500.27368@cbobk.fhfr.pm>
 <1460616590.2754.6.camel@ellerman.id.au> <20160414125735.GA20296@lst.de>
 <1460639282.21066.5.camel@ellerman.id.au> <20160414152029.GA24525@lst.de>
 <20160414164122.7ubcqqm43advdscb@treble>
 <1460719369.22415.1.camel@ellerman.id.au>
 <20160415125939.lrft3nawlzuozjkb@treble>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-04-15 at 07:59 -0500, Josh Poimboeuf wrote:
> On Fri, Apr 15, 2016 at 09:22:49PM +1000, Michael Ellerman wrote:
> > On Thu, 2016-04-14 at 11:41 -0500, Josh Poimboeuf wrote:
> > > On Thu, Apr 14, 2016 at 05:20:29PM +0200, Torsten Duwe wrote:
> > > > On Thu, Apr 14, 2016 at 11:08:02PM +1000, Michael Ellerman wrote:
> > > > > On Thu, 2016-04-14 at 14:57 +0200, Torsten Duwe wrote:
> > > > > > FTR: then I still have a few ppc64 hunks floating around to support certain consistency
> > > > > > models...
> > > > > 
> > > > > OK. I'm not quite sure what you mean but post them and we'll see I guess :)
> > > > 
> > > > It's *roughly* the ppc64 equivalent of Josh Poimboeuf's Mar 25
> > > > > [RFC PATCH v1.9 14/14] livepatch: update task universe when exiting kernel
> > > > which only considers x86.
> > > > 
> > > > It's forward ported from an earlier code base; there's some glue missing,
> > > > but here it is, for reference.
> > > > 
> > > > Signed-off-by: Torsten Duwe <duwe@suse.de>
> > > 
> > > Hi Torsten,
> > > 
> > > Thanks for sharing.  This is quite fortuitous as Miroslav just today
> > > mentioned to me that we would need something like this.  If you don't
> > > mind, I may pull this patch or some variant of it into v2 of the
> > > consistency model.
> >  
> > Well please wait for me to review & ack it before you pull it into anything
> > permanent.
> > 
> > At a quick glance it seems OK but I'd probably do it a little differently. I'll
> > try and have a closer look next week.
> 
> Sure, no problem.  The consistency model patches are still in
> development so they won't be merged anytime soon.  And we wouldn't merge
> any powerpc code without maintainer acks anyway.  I'm just glad you guys
> are looking at it so I don't have to butcher it ;-)

I'm paid to butcher it ;)

cheers
