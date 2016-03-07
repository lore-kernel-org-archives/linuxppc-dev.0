Return-Path: <jpoimboe@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71E251A02A0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 10:22:10 +1100 (AEDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 20A1D140213
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2016 10:22:10 +1100 (AEDT)
Date: Mon, 7 Mar 2016 17:22:06 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Petr Mladek <pmladek@suse.com>,
 linuxppc-dev@ozlabs.org, jeyu@redhat.com, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, duwe@lst.de,
 live-patching@vger.kernel.org, mbenes@suse.cz,
 Torsten Duwe <duwe@suse.de>, vojtech@suse.com, sjenning@redhat.com
Subject: Re: How to merge? (was Re: [PATCH][v4] livepatch/ppc: Enable
 livepatching on powerpc)
Message-ID: <20160307232206.GB8500@treble.redhat.com>
References: <1457023921-2051-1-git-send-email-pmladek@suse.com>
 <1457078800.20076.4.camel@ellerman.id.au>
 <alpine.LNX.2.00.1603040952330.3656@cbobk.fhfr.pm>
 <1457345161.18915.3.camel@ellerman.id.au>
 <alpine.LNX.2.00.1603072348280.3656@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.LNX.2.00.1603072348280.3656@cbobk.fhfr.pm>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 07, 2016 at 11:52:31PM +0100, Jiri Kosina wrote:
> On Mon, 7 Mar 2016, Michael Ellerman wrote:
> 
> > > This aligns with my usual workflow, so that'd be my preferred way of doing
> > > things; i.e. you put all the ftrace changes into a separate topic branch,
> > > and then
> > >
> > > - you pull that branch into powerpc#next
> > > - I pull that branch into livepatching tree
> > > - I apply the ppc livepatching support on top of that
> > > - I send a pull request to Linus only after powerpc#next gets merged to
> > >   Linus' tree
> > >
> > > Sounds good?
> > 
> > Yep, here it is:
> > 
> >   https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/log/?h=topic/mprofile-kernel
> > 
> > aka:
> > 
> >   git fetch git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git topic/mprofile-kernel
> 
> Excellent, thanks.
> 
> > I haven't merged it into my next yet, but I will tomorrow unless you tell me
> > there's something wrong with it.
> 
> There is one remaining issue which I think would be really nice to 
> have(TM), and that's Steven's Ack for the whole thing :)
> 
> For the livepatching part, I don't think we are quite there yet (so maybe 
> it'll miss the upcoming merge window anyway).
> 
> My primary worry there is what Torsten pointed out, i.e. functions with 
> either varargs or more than 8 args needing special care.
> 
> Also, I'd like to have this positively reviewed by at least one more 
> livepatching maintainer (I am currently looking into it myself, but my 
> understanding of powerpc arch is rather low, so the more eyes, the 
> better).

It's been a few years but I'll try to dust off my powerpc chops and give
it a proper review.

-- 
Josh
