Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7647ADE08A
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 19:04:19 +1000 (EST)
Subject: Re: CONFIG_BOOTX_TEXT breaks PowerBook 3400 with BootX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Finn Thain <fthain@telegraphics.com.au>
In-Reply-To: <Pine.LNX.4.64.0808201819500.22930@loopy.telegraphics.com.au>
References: <Pine.LNX.4.64.0808200148080.24338@loopy.telegraphics.com.au>
	<1219205249.21386.7.camel@pasglop>
	<Pine.LNX.4.64.0808201819500.22930@loopy.telegraphics.com.au>
Content-Type: text/plain
Date: Wed, 20 Aug 2008 19:04:12 +1000
Message-Id: <1219223052.21386.48.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-08-20 at 18:25 +1000, Finn Thain wrote:
> 
> On Wed, 20 Aug 2008, Benjamin Herrenschmidt wrote:
> 
> > On Wed, 2008-08-20 at 03:23 +1000, Finn Thain wrote:
> > >...
> > > 
> > > The Debian Sarge 2.6.8-4 kernel does not seem to have this problem 
> > > though kernel.org 2.6.16 and later versions do.
> > > 
> > > Any ideas?
> > 
> > How "late" have you tried ? I remember fixing something at one point...
> 
> I've tried 2.6.26.2 (I think I also tried 2.6.22 and 2.6.25 a while ago).
> 
> I did some more tests today. I found that 2.6.15 (ARCH=ppc) is fine, but 
> 2.6.16 (ARCH=powerpc) has the bug.

Thanks. I can get access to a 3400, I'll give it a try.

Cheers,
Ben.
