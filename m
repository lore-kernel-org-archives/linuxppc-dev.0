Return-Path: <trini@kernel.crashing.org>
Date: Mon, 5 Jun 2006 14:04:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Matthew McClintock <msm@freescale.com>
Subject: Re: [HACK] add sandpoint + flattened dt support to arch/powerpc/boot
Message-ID: <20060605210423.GI25980@smtp.west.cox.net>
References: <20060518002142.GA23182@mag.az.mvista.com>
	<1147960021.7607.5.camel@localhost.localdomain>
	<20060519003730.GA7338@mag.az.mvista.com>
	<1147999765.8515.6.camel@localhost.localdomain>
	<20060522222227.GR32112@smtp.west.cox.net>
	<1149540113.8317.93.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1149540113.8317.93.camel@localhost.localdomain>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 05, 2006 at 03:41:53PM -0500, Matthew McClintock wrote:
> On Mon, 2006-05-22 at 15:22 -0700, Tom Rini wrote:
> > And on all architectures (practically) the zlib inflate code is shared
> > between kernel and bootstuff.  So it's not unprecidented to do the
> > ugly
> > define abstractions to let you easily share code as needed. 
> 
> Could you point me at the code you are referring too?

arch/powerpc/boot/Makefile
arch/ppc/boot/lib/Makefile
arch/xtensa/boot/lib/Makefile

And I could have sworn there were other arches (maybe in patches in
-mm?) that switched from lib/inflate.c to lib/zlib_inflate/

-- 
Tom Rini
