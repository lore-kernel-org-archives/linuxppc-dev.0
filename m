Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id E5EC4DDE0F
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 00:42:19 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Thu, 26 Apr 2007 07:42:18 -0700
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/13] powerpc: Add arch/powerpc mv64x60 PCI setup
Message-ID: <20070426144218.GD29241@xyzzy.farnsworth.org>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<200704260225.27740.arnd@arndb.de>
	<20070426063315.GE2030@xyzzy.farnsworth.org>
	<200704261339.18640.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200704261339.18640.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 26, 2007 at 01:39:18PM +0200, Arnd Bergmann wrote:
> On Thursday 26 April 2007, Dale Farnsworth wrote:
> > > /* The probing of PCI controllers from of_platform is currently
> > > ?* 64 bits only, mostly due to gratuitous differences between
> > > ?* the 32 and 64 bits PCI code on PowerPC and the 32 bits one
> > > ?* lacking some bits needed here.
> > > ?*/
> > 
> > Is this comment incorrect?
> > 
> > I agree that this is more code duplication than I like, and we could
> > benefit from some refactoring. ?However, I find 15 other places in
> > arch/powerpc that largely duplicate this pci initialization code.
> > That doesn't make a 16th right, but at least I'm in good company. 
> 
> Yes, you're right. I was assuming that the code had been ported to
> 32 bit already, which was incorrect.
> 
> While I would very much like you (or someone else) to make it work,
> it should not be a prerequisite to get your code merged in 2.6.22.
> 
> The one remaining comment I have about this one is that IMHO it
> should be a separate file, mv64x60-pci.c instead of being
> in the same file as the interrupt controller and other code.

Ah, the debate continues.  I remember 4 or 5 years ago there was
campaign to consolidate the xxxx-pci.c files into the core support
files.  I have no strong preference.  More opinions are welcome.

Thanks,
-Dale
