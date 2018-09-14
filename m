Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Bp6B5nDMzF2QG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 07:08:50 +1000 (AEST)
Date: Fri, 14 Sep 2018 16:08:41 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: joel@jms.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/5] powerpc/boot: Fix crt0.S syntax for clang
Message-ID: <20180914210840.GT23155@gate.crashing.org>
References: <20180914040649.1794-1-joel@jms.id.au>
 <20180914040649.1794-3-joel@jms.id.au>
 <CAKwvOdmKvxmh+Vb1UcUzOsYOsK6gjn7v62X=SpwuhimBhdM7ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKwvOdmKvxmh+Vb1UcUzOsYOsK6gjn7v62X=SpwuhimBhdM7ng@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 14, 2018 at 10:47:08AM -0700, Nick Desaulniers wrote:
> On Thu, Sep 13, 2018 at 9:07 PM Joel Stanley <joel@jms.id.au> wrote:
> >  10:    addis   r12,r12,(-RELACOUNT)@ha
> > -       cmpdi   r12,RELACOUNT@l
> > +       cmpdi   r12,(RELACOUNT)@l
> 
> Yep, as we can see above, when RELACOUNT is negated, it's wrapped in
> parens.

The only thing that does is make it easier for humans to read; it means
exactly the same thing.


Segher
