Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3E98AB7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Aug 2009 10:47:33 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 93E2EDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 10:47:32 +1000 (EST)
Subject: Re: [PATCH 3/3] agp/uninorth: Unify U3 and pre-U3 insert_memory
	and remove_memory hooks.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
In-Reply-To: <1250151313.4992.202.camel@thor>
References: <1249422665-24437-1-git-send-email-michel@daenzer.net>
	<1249422665-24437-3-git-send-email-michel@daenzer.net>
	<1250147148.3587.115.camel@pasglop>  <1250151313.4992.202.camel@thor>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 20 Aug 2009 10:47:12 +1000
Message-Id: <1250729232.4810.43.camel@pasglop>
Mime-Version: 1.0
Cc: Dave Airlie <airlied@linux.ie>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-08-13 at 10:15 +0200, Michel Dänzer wrote:
> On Thu, 2009-08-13 at 17:05 +1000, Benjamin Herrenschmidt wrote:
> > On Tue, 2009-08-04 at 23:51 +0200, Michel Dänzer wrote:
> > > From: Michel Dänzer <daenzer@vmware.com>
> > > 
> > > Signed-off-by: Michel Dänzer <daenzer@vmware.com>
> > > ---
> > 
> > Hi Michel !
> > 
> > While your two previous patches apply just fine, this one doesn't,
> > the uninorth_insert_memory() function seems to be slightly different
> > upstream. Does this depend on some separate yet unapplied patches ?
> 
> I previously sent the attached patches to Dave in the course of the
> radeon KMS issues thread. Not sure which of these he's picked up yet, if
> any.

I merged the first two patches in your series, we can sort out the 3rd
one in a second pass on the merge window.

Cheers,
Ben.

> 
> > I'm putting 1/3 and 2/3 into my -test branch and they should hit my
> > -next branch in a couple of days.
> > 
> > Or do you prefer us to merge that via Dave ?
> > 
> > The thing is, stuff in -powerpc is much more likely to get some amount
> > of testing on actual ppc hardware than stuff in random other trees :-)
> 
> I'm fine with either way.
> 
> 
