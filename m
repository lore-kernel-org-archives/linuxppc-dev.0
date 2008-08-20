Return-Path: <fthain@telegraphics.com.au>
Received: from loopy.telegraphics.com.au (loopy.telegraphics.com.au
	[202.45.126.152]) by ozlabs.org (Postfix) with ESMTP id 8527CDE154
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 18:25:43 +1000 (EST)
Date: Wed, 20 Aug 2008 18:25:42 +1000 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: CONFIG_BOOTX_TEXT breaks PowerBook 3400 with BootX
In-Reply-To: <1219205249.21386.7.camel@pasglop>
Message-ID: <Pine.LNX.4.64.0808201819500.22930@loopy.telegraphics.com.au>
References: <Pine.LNX.4.64.0808200148080.24338@loopy.telegraphics.com.au>
	<1219205249.21386.7.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Wed, 20 Aug 2008, Benjamin Herrenschmidt wrote:

> On Wed, 2008-08-20 at 03:23 +1000, Finn Thain wrote:
> >...
> > 
> > The Debian Sarge 2.6.8-4 kernel does not seem to have this problem 
> > though kernel.org 2.6.16 and later versions do.
> > 
> > Any ideas?
> 
> How "late" have you tried ? I remember fixing something at one point...

I've tried 2.6.26.2 (I think I also tried 2.6.22 and 2.6.25 a while ago).

I did some more tests today. I found that 2.6.15 (ARCH=ppc) is fine, but 
2.6.16 (ARCH=powerpc) has the bug.

Finn

> 
> Ben.
> 
> 
> 
