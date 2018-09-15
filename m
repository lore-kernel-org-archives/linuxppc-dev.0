Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Bvpc393BzF37Z
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 11:25:44 +1000 (AEST)
Date: Fri, 14 Sep 2018 20:04:11 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, joel@jms.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 5/5] powerpc: Remove -mno-sched-epilog
Message-ID: <20180915010410.GA23155@gate.crashing.org>
References: <20180914040649.1794-1-joel@jms.id.au>
 <20180914040649.1794-6-joel@jms.id.au>
 <20180914150629.405c12cc@roar.ozlabs.ibm.com>
 <CAKwvOdn-e60VSvUzmSLGx6yx-wUzSaEtdA3q5xyZ+G_++nQSJg@mail.gmail.com>
 <20180915064305.65eea265@roar.ozlabs.ibm.com>
 <20180914211846.GU23155@gate.crashing.org>
 <CAKwvOdmsSbrw7oLZHWTseqxLocPmuXV=cnxSi2zskAmd9zKo0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKwvOdmsSbrw7oLZHWTseqxLocPmuXV=cnxSi2zskAmd9zKo0Q@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 14, 2018 at 03:20:18PM -0700, Nick Desaulniers wrote:
> On Fri, Sep 14, 2018 at 2:56 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> > On Sat, Sep 15, 2018 at 06:43:05AM +1000, Nicholas Piggin wrote:
> > > On Fri, 14 Sep 2018 11:03:38 -0700
> > > Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > Sorry I forgot to cc you. This has links to some of the sched
> > > epilog bugs.
> > >
> > > https://marc.info/?l=linuxppc-embedded&m=153690223909654&w=2
> 
> Cool, cc me on the thread if you'd like me to add my reviewed-by tag
> visibly on the thread.
> 
> > PR44199 was backported to 4.4 and PR52828 is fixed in 4.8.
> 
> Are those GCC versions? If so, what does that mean for the users of
> the many GCC releases between 4.4 and 4.8?

Yes, GCC bug 44199 was fixed in GCC version 4.4, etc.  It of course also
is fixed in all later versions; so GCC releases between 4.4 and 4.8 have
the fix for PR44199 but not that for PR52828.

I didn't check exactly what 4.4.x versions have the fix, etc.  I always
assume anyone using x.y.z uses the highest z available.

I don't know if those are the only fixes you need; those are the two
bugs mentioned in Nicholas' patch (that MARC link above).


Segher
