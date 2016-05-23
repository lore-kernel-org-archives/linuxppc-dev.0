Return-Path: <rpjday@crashcourse.ca>
Received: from smtp684.redcondor.net (smtp684.redcondor.net [208.80.206.84])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rCqX92qxrzDqCj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 17:13:43 +1000 (AEST)
Date: Mon, 23 May 2016 03:12:44 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Russell Currey <ruscur@russell.cc>
cc: Andrea Gelmini <andrea.gelmini@gelma.net>, trivial@kernel.org,
 linuxppc-dev@lists.ozlabs.org, paulus@samba.org
Subject: Re: [PATCH 0213/1529] Fix typo
In-Reply-To: <1463967017.2414.2.camel@russell.cc>
Message-ID: <alpine.LFD.2.20.1605230312150.23426@Device-040570>
References: <20160521120353.11023-1-andrea.gelmini@gelma.net>
 <1463967017.2414.2.camel@russell.cc>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="-1463808767-1116047029-1463987568=:23426"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463808767-1116047029-1463987568=:23426
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 23 May 2016, Russell Currey wrote:

> On Sat, 2016-05-21 at 14:03 +0200, Andrea Gelmini wrote:
> > Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> > ---
>
> This entire comment needs to be rewritten as it's incredibly confusing, but alas
>
> Acked-by: Russell Currey <ruscur@russell.cc>
>
> >  arch/powerpc/include/asm/eeh.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> > index fb9f376..7d34f3d 100644
> > --- a/arch/powerpc/include/asm/eeh.h
> > +++ b/arch/powerpc/include/asm/eeh.h
> > @@ -57,7 +57,7 @@ struct pci_dn;
> >  /*
> >   * The struct is used to trace PE related EEH functionality.
> >   * In theory, there will have one instance of the struct to

  "there will have one instance"?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
---1463808767-1116047029-1463987568=:23426--
