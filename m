Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 16D4D6884E
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Dec 2005 05:24:53 +1100 (EST)
Date: Fri, 2 Dec 2005 16:24:47 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20051202182447.GA7579@dmt.cnet>
References: <20051117151730.GA10180@logos.cnet>
	<20051128232738.GE7766@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051128232738.GE7766@smtp.west.cox.net>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: INTERACTIVE_CONSOLE for misc-embedded.c and watchdog issue
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Tom,

On Mon, Nov 28, 2005 at 04:27:38PM -0700, Tom Rini wrote:
> On Thu, Nov 17, 2005 at 01:17:30PM -0200, Marcelo Tosatti wrote:
> 
> > The following patch against misc-embedded.c adds an INTERACTIVE_CONSOLE
> > #define to guard reading from console (causes unecessary delay in some
> > situations).
> > 
> > Its an adaptation of misc.c's define, a difference being that platform
> > headers define "NO_INTERACTIVE_CONSOLE" if required.
> > 
> > What do you think?
> 
> Please put a comment above the #ifndef stating where the define should
> be.  But I have a feeling that's going to be somewhere under
> arch/ppc/platforms/ or include/asm-ppc/ and I don't know if that's a
> good idea...

arch/ppc/platforms/ surely. You have a problem with that?

> I've got a vauge idea on how we can handle this a little bit more
> cleanly, in the merge tree.

How's that? Should I cancel the patch, then? 
