Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDL5m1G0rzDqNX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 13:11:08 +1000 (AEST)
Message-ID: <1464059461.32034.1.camel@ellerman.id.au>
Subject: Re: [PATCH 0213/1529] Fix typo
From: Michael Ellerman <mpe@ellerman.id.au>
To: Russell Currey <ruscur@russell.cc>, "Robert P. J. Day"
 <rpjday@crashcourse.ca>
Cc: linuxppc-dev@lists.ozlabs.org, Andrea Gelmini
 <andrea.gelmini@gelma.net>,  trivial@kernel.org, paulus@samba.org
Date: Tue, 24 May 2016 13:11:01 +1000
In-Reply-To: <1464048297.2237.1.camel@russell.cc>
References: <20160521120353.11023-1-andrea.gelmini@gelma.net>
 <1463967017.2414.2.camel@russell.cc>
 <alpine.LFD.2.20.1605230312150.23426@Device-040570>
 <1464048297.2237.1.camel@russell.cc>
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

On Tue, 2016-05-24 at 10:04 +1000, Russell Currey wrote:
> On Mon, 2016-05-23 at 03:12 -0400, Robert P. J. Day wrote:
> > On Mon, 23 May 2016, Russell Currey wrote:
> > > On Sat, 2016-05-21 at 14:03 +0200, Andrea Gelmini wrote:
> > > > Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> > > > ---
> > > 
> > > This entire comment needs to be rewritten as it's incredibly confusing, but
> > > alas
> > > 
> > > Acked-by: Russell Currey <ruscur@russell.cc>
> > > 
> > > >  arch/powerpc/include/asm/eeh.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/powerpc/include/asm/eeh.h
> > > > b/arch/powerpc/include/asm/eeh.h
> > > > index fb9f376..7d34f3d 100644
> > > > --- a/arch/powerpc/include/asm/eeh.h
> > > > +++ b/arch/powerpc/include/asm/eeh.h
> > > > @@ -57,7 +57,7 @@ struct pci_dn;
> > > >  /*
> > > >   * The struct is used to trace PE related EEH functionality.
> > > >   * In theory, there will have one instance of the struct to
> > 
> >   "there will have one instance"?
> 
> See "This entire comment needs to be rewritten as it's incredibly confusing" :)
> 
> EEH documentation, both in source and in Documentation/powerpc/, is very much in
> need of updates and reworks.  I'm working on it.

Thanks. I'll wait for that, I'm not interested in merging a single byte typo
fix to an otherwise badly worded comment.

cheers
