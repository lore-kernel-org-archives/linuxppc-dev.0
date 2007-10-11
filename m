Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18189.27251.48582.614106@cargo.ozlabs.ibm.com>
Date: Thu, 11 Oct 2007 10:12:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Build failure on treeboot-walnut.cg
In-Reply-To: <470BA6ED.3020504@freescale.com>
References: <fa686aa40709251546p725e66dcsbc0483cadb3ec3fb@mail.gmail.com>
	<470AA224.7050709@freescale.com>
	<20071009030729.GI12499@localhost.localdomain>
	<470BA6ED.3020504@freescale.com>
Cc: linuxppc-dev@ozlabs.com, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi writes:

> Is this a new policy?  Modules in the kernel are not built unless you want 
> them.  Even in arch/powerpc/platforms, only the specific platform file I'm 
> targeting is built.  So I don't really understand why you claim it's normal 
> for platform-specific files to be built, regardless of the actual platform.

The wrapper script is intended to be a standalone tool which is
independent of the kernel configuration, and can be used separately
from the kernel build process.

> And frankly, I don't like this "policy".  Build bugs for 4xx should not 
> interfere in my 83xx development.  I can't build any kernels now because of 
> this bug!

I'm sure you're not actually that helpless. :)  Just carry a patch to
arch/powerpc/boot/Makefile in your local tree.

Paul.
