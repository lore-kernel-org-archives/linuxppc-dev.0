Return-Path: <jwboyer@jdub.homelinux.org>
Date: Tue, 9 Oct 2007 13:52:35 -0500
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Build failure on treeboot-walnut.cg
Message-ID: <20071009135235.1026bb23@vader.jdub.homelinux.org>
In-Reply-To: <470BA6ED.3020504@freescale.com>
References: <fa686aa40709251546p725e66dcsbc0483cadb3ec3fb@mail.gmail.com>
	<470AA224.7050709@freescale.com>
	<20071009030729.GI12499@localhost.localdomain>
	<470BA6ED.3020504@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.com,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 09 Oct 2007 11:06:05 -0500
Timur Tabi <timur@freescale.com> wrote:

> David Gibson wrote:
> 
> > Policy.  Compiling everything means build bugs - like this one - can
> > be found by everybody, not just those building for the specific
> > obscure platform.
> 
> Is this a new policy?  Modules in the kernel are not built unless you want 
> them.  Even in arch/powerpc/platforms, only the specific platform file I'm 
> targeting is built.  So I don't really understand why you claim it's normal 
> for platform-specific files to be built, regardless of the actual platform.
> 
> And frankly, I don't like this "policy".  Build bugs for 4xx should not 
> interfere in my 83xx development.  I can't build any kernels now because of 
> this bug!

I fixed this bug.  It should be in Paul's latest tree.  You seem to be
having a different issue with your binutils though.

josh
