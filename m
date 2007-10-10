Return-Path: <dgibson@ozlabs.org>
Date: Wed, 10 Oct 2007 12:35:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Build failure on treeboot-walnut.cg
Message-ID: <20071010023515.GA32426@localhost.localdomain>
References: <fa686aa40709251546p725e66dcsbc0483cadb3ec3fb@mail.gmail.com>
	<470AA224.7050709@freescale.com>
	<20071009030729.GI12499@localhost.localdomain>
	<470BA6ED.3020504@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <470BA6ED.3020504@freescale.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 09, 2007 at 11:06:05AM -0500, Timur Tabi wrote:
> David Gibson wrote:
> 
> > Policy.  Compiling everything means build bugs - like this one - can
> > be found by everybody, not just those building for the specific
> > obscure platform.
> 
> Is this a new policy?  Modules in the kernel are not built unless you want 
> them.  Even in arch/powerpc/platforms, only the specific platform file I'm 
> targeting is built.  So I don't really understand why you claim it's normal 
> for platform-specific files to be built, regardless of the actual
> platform.

It has been policy as long as we've had the platform+library structure
in arch/powerpc/boot.

> And frankly, I don't like this "policy".  Build bugs for 4xx should not 
> interfere in my 83xx development.  I can't build any kernels now because of 
> this bug!

Argue with Paulus.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
