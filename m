Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Bq9r1903zF368
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 07:57:03 +1000 (AEST)
Date: Fri, 14 Sep 2018 16:18:46 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, joel@jms.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 5/5] powerpc: Remove -mno-sched-epilog
Message-ID: <20180914211846.GU23155@gate.crashing.org>
References: <20180914040649.1794-1-joel@jms.id.au>
 <20180914040649.1794-6-joel@jms.id.au>
 <20180914150629.405c12cc@roar.ozlabs.ibm.com>
 <CAKwvOdn-e60VSvUzmSLGx6yx-wUzSaEtdA3q5xyZ+G_++nQSJg@mail.gmail.com>
 <20180915064305.65eea265@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180915064305.65eea265@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 15, 2018 at 06:43:05AM +1000, Nicholas Piggin wrote:
> On Fri, 14 Sep 2018 11:03:38 -0700
> Nick Desaulniers <ndesaulniers@google.com> wrote:
> 
> > On Thu, Sep 13, 2018 at 9:07 PM Joel Stanley <joel@jms.id.au> wrote:
> > > Last time this was proposed there was an issue reported:
> > >
> > >  https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-September/121214.html  
> > 
> > Heh, did PASemi sell boxes? Interesting, I'll have to read up on my history.
> > 
> > On Thu, Sep 13, 2018 at 10:06 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> > > I don't think we can remove it completely because up to at least 4.6
> > > maybe 4.8 has problems.
> > >
> > > I have a few patches lying around I started looking at this... I'll
> > > send them.  
> > 
> > Yeah, it's too bad the link above doesn't mention gcc version.
> > 
> > The gcc bugreport mentions fixing the bug in
> > 7563dc64585324f443f5ac107eb6d89ee813a2d2, not sure how to check what
> > release version of gcc that is? (Do they tag releases?)
> 
> I'm not sure, that's not in my gcc tree AFAIKS.

This is a git hash in the kernel tree.

> > Nick, do you have a test case or more context about this still being
> > an issue in gcc 4.8? (maybe I should wait for your patch series?)
> 
> Sorry I forgot to cc you. This has links to some of the sched
> epilog bugs.
> 
> https://marc.info/?l=linuxppc-embedded&m=153690223909654&w=2

PR44199 was backported to 4.4 and PR52828 is fixed in 4.8.


Segher
