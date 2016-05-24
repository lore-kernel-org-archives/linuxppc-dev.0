Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDFz72TJYzDqNL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 10:05:07 +1000 (AEST)
Message-ID: <1464048297.2237.1.camel@russell.cc>
Subject: Re: [PATCH 0213/1529] Fix typo
From: Russell Currey <ruscur@russell.cc>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, trivial@kernel.org,
 linuxppc-dev@lists.ozlabs.org, paulus@samba.org
Date: Tue, 24 May 2016 10:04:57 +1000
In-Reply-To: <alpine.LFD.2.20.1605230312150.23426@Device-040570>
References: <20160521120353.11023-1-andrea.gelmini@gelma.net>
 <1463967017.2414.2.camel@russell.cc>
 <alpine.LFD.2.20.1605230312150.23426@Device-040570>
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

On Mon, 2016-05-23 at 03:12 -0400, Robert P. J. Day wrote:
> On Mon, 23 May 2016, Russell Currey wrote:
> 
> > On Sat, 2016-05-21 at 14:03 +0200, Andrea Gelmini wrote:
> > > Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> > > ---
> > 
> > This entire comment needs to be rewritten as it's incredibly confusing, but
> > alas
> > 
> > Acked-by: Russell Currey <ruscur@russell.cc>
> > 
> > >  arch/powerpc/include/asm/eeh.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/powerpc/include/asm/eeh.h
> > > b/arch/powerpc/include/asm/eeh.h
> > > index fb9f376..7d34f3d 100644
> > > --- a/arch/powerpc/include/asm/eeh.h
> > > +++ b/arch/powerpc/include/asm/eeh.h
> > > @@ -57,7 +57,7 @@ struct pci_dn;
> > >  /*
> > >   * The struct is used to trace PE related EEH functionality.
> > >   * In theory, there will have one instance of the struct to
> 
>   "there will have one instance"?

See "This entire comment needs to be rewritten as it's incredibly confusing" :)

EEH documentation, both in source and in Documentation/powerpc/, is very much in
need of updates and reworks.  I'm working on it.

- Russell
