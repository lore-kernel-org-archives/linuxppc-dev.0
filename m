Return-Path: <judith@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6CEFA67B69
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Sep 2006 05:23:11 +1000 (EST)
Date: Fri, 15 Sep 2006 12:22:42 -0700
From: Judith Lebzelter <judith@osdl.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: 'make ARCH=ppc defconfig' failing for cross-compile
Message-ID: <20060915192242.GC10646@shell0.pdx.osdl.net>
References: <20060909000512.GF9335@shell0.pdx.osdl.net>
	<Pine.LNX.4.64.0609100652160.16347@sheep.housecafe.de>
	<20060912174814.GA29226@shell0.pdx.osdl.net>
	<1158203522.7305.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1158203522.7305.14.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Judith Lebzelter <judith@osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 14, 2006 at 01:12:01PM +1000, Michael Ellerman wrote:
> On Tue, 2006-09-12 at 10:48 -0700, Judith Lebzelter wrote:
> > On Tue, Sep 12, 2006 at 10:21:46AM -0700, Christian wrote:
> > > On Fri, 8 Sep 2006, Judith Lebzelter wrote:
> > > > I have been doing cross-compiles for ppc and powerpc on my i686 system.
> > > > In order to do this I generate the .config file like this:
> > > >
> > > > make ARCH=ppc defconfig
> > > > (or make ARCH=powerpc defconfig)
> > > 
> > > Seems like defconfig has been removed, because there are so many 
> > > sub-platforms for ppc:
> > 
> > I build these in OSDL's cross compile build farm (PLM) as a code check.
> > Our scripts are generalized to work for various architectures, so it is
> > disappointing that 'defconfig' no longer works for ppc the way it does 
> > in other achitectures.  Are there plans to make plain 'defconfig' work 
> > again, at least in the new 'powerpc' directory?  (The 'ppc64_defconfig' 
> > target looks good to me.:)
> 
> Perhaps you need to rework the scripts to cope for the fact that there
> are different platforms under the architecture? There will never be a
> defconfig for powerpc that builds all the code for all platforms, so to
> get full test coverage you'll need to build more than one config anyway.
> 

Yes, I do not get full code coverage, which would be the ideal.
However, I do run defconfig, allmodconfig, allyesconfig and allnoconfig
and have found issues doing this. There is value in running for a
few representative ppc architectures, which I do.  That is why 'defconfig'
is (was) handy for me. 

I additionally compile other architectures such as i386, ia64, x86_64, 
arm, sparc64.  People can submit their kernel patches to see how 
their code compiles, and usually this is more platforms than they would 
do at home.:)

Thanks,
Judith

> cheers
> 
> -- 
> Michael Ellerman
> OzLabs, IBM Australia Development Lab
> 
> wwweb: http://michael.ellerman.id.au
> phone: +61 2 6212 1183 (tie line 70 21183)
> 
> We do not inherit the earth from our ancestors,
> we borrow it from our children. - S.M.A.R.T Person
