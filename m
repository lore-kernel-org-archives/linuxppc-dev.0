Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D3435DDFD2
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 00:10:07 +1000 (EST)
Date: Tue, 7 Apr 2009 09:11:54 -0500
From: Olof Johansson <olof@lixom.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Add configurable -Werror for arch/powerpc
Message-ID: <20090407141154.GA30654@lixom.net>
References: <b0b55030b7ba669cbdec74a8b89875096ea07622.1239069602.git.michael@ellerman.id.au>
	<20090407022743.GA12174@lixom.net>
	<1239073293.6565.18.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1239073293.6565.18.camel@localhost>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 07, 2009 at 03:01:33AM +0000, Michael Ellerman wrote:
> On Mon, 2009-04-06 at 21:27 -0500, Olof Johansson wrote:
> > On Tue, Apr 07, 2009 at 12:00:41PM +1000, Michael Ellerman wrote:
> > > Add an option, on by default, to build all code under arch/powerpc with
> > > -Werror, which causes gcc to treat warnings as errors.
> > > 
> > > The intention is to make it harder for people to inadvertantly introduce
> > > errors in the arch/powerpc code. It needs to be configurable so that
> > > if a warning is introduced, people can easily work around it while it's
> > > being fixed.
> > 
> > This looks useful at least for the automated builds to catch new warnings,
> > but do similar options exist on other architectures, x86 in particular? I
> > think a Cc to LKML of this could be useful.
> > 
> > This is really only beneficial if various people build for powerpc often
> > enough. If major subsystem maintainers aren't going to hit the errors
> > it's more of a hinderance for PPC than a global benefit, right?
> 
> I don't think so. We're only enabling it for code under arch/powerpc -
> and most modifications to that code should come through linuxppc.

Good point.

> It's still possible that random stuff will get merged, or that someone
> will change code in a header that only causes warnings on powerpc, but
> it's less likely.
> 
> And that's why it's an option, if someone breaks the build we can work
> around it until they're appropriately LARTed.

Yeah, sounds good to me.


-Olof
