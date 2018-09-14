Return-Path: <ndesaulniers@google.com>
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Bqhx0TKwzF36k
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 08:20:31 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id l63-v6so5003240pga.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 15:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180914040649.1794-1-joel@jms.id.au>
 <20180914040649.1794-6-joel@jms.id.au>
 <20180914150629.405c12cc@roar.ozlabs.ibm.com>
 <CAKwvOdn-e60VSvUzmSLGx6yx-wUzSaEtdA3q5xyZ+G_++nQSJg@mail.gmail.com>
 <20180915064305.65eea265@roar.ozlabs.ibm.com>
 <20180914211846.GU23155@gate.crashing.org>
In-Reply-To: <20180914211846.GU23155@gate.crashing.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 14 Sep 2018 15:20:18 -0700
Message-ID: <CAKwvOdmsSbrw7oLZHWTseqxLocPmuXV=cnxSi2zskAmd9zKo0Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] powerpc: Remove -mno-sched-epilog
To: segher@kernel.crashing.org
Cc: Nicholas Piggin <npiggin@gmail.com>, joel@jms.id.au,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 14, 2018 at 2:56 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Sat, Sep 15, 2018 at 06:43:05AM +1000, Nicholas Piggin wrote:
> > On Fri, 14 Sep 2018 11:03:38 -0700
> > Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > > On Thu, Sep 13, 2018 at 9:07 PM Joel Stanley <joel@jms.id.au> wrote:
> > > > Last time this was proposed there was an issue reported:
> > > >
> > > >  https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-September/121214.html
> > >
> > > Heh, did PASemi sell boxes? Interesting, I'll have to read up on my history.
> > >
> > > On Thu, Sep 13, 2018 at 10:06 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> > > > I don't think we can remove it completely because up to at least 4.6
> > > > maybe 4.8 has problems.
> > > >
> > > > I have a few patches lying around I started looking at this... I'll
> > > > send them.
> > >
> > > Yeah, it's too bad the link above doesn't mention gcc version.
> > >
> > > The gcc bugreport mentions fixing the bug in
> > > 7563dc64585324f443f5ac107eb6d89ee813a2d2, not sure how to check what
> > > release version of gcc that is? (Do they tag releases?)
> >
> > I'm not sure, that's not in my gcc tree AFAIKS.
>
> This is a git hash in the kernel tree.
>
> > > Nick, do you have a test case or more context about this still being
> > > an issue in gcc 4.8? (maybe I should wait for your patch series?)
> >
> > Sorry I forgot to cc you. This has links to some of the sched
> > epilog bugs.
> >
> > https://marc.info/?l=linuxppc-embedded&m=153690223909654&w=2

Cool, cc me on the thread if you'd like me to add my reviewed-by tag
visibly on the thread.

>
> PR44199 was backported to 4.4 and PR52828 is fixed in 4.8.

Are those GCC versions? If so, what does that mean for the users of
the many GCC releases between 4.4 and 4.8?

-- 
Thanks,
~Nick Desaulniers
