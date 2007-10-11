Return-Path: <scottwood@freescale.com>
Date: Thu, 11 Oct 2007 15:02:37 -0500
From: Scott Wood <scottwood@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Build failure on treeboot-walnut.cg
Message-ID: <20071011200237.GB4247@loki.buserror.net>
References: <fa686aa40709251546p725e66dcsbc0483cadb3ec3fb@mail.gmail.com>
	<470AA224.7050709@freescale.com>
	<20071009030729.GI12499@localhost.localdomain>
	<470BA6ED.3020504@freescale.com>
	<18189.27251.48582.614106@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18189.27251.48582.614106@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.com, Timur Tabi <timur@freescale.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 11, 2007 at 10:12:35AM +1000, Paul Mackerras wrote:
> Timur Tabi writes:
> 
> > Is this a new policy?  Modules in the kernel are not built unless you want 
> > them.  Even in arch/powerpc/platforms, only the specific platform file I'm 
> > targeting is built.  So I don't really understand why you claim it's normal 
> > for platform-specific files to be built, regardless of the actual platform.
> 
> The wrapper script is intended to be a standalone tool which is
> independent of the kernel configuration, and can be used separately
> from the kernel build process.

Is it ever actually used that way?  I wonder if this "intent" is worth the
pain...

-Scott
