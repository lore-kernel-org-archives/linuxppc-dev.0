Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 212BB68802
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 10:27:39 +1100 (EST)
Date: Mon, 28 Nov 2005 16:27:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20051128232738.GE7766@smtp.west.cox.net>
References: <20051117151730.GA10180@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051117151730.GA10180@logos.cnet>
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

On Thu, Nov 17, 2005 at 01:17:30PM -0200, Marcelo Tosatti wrote:

> The following patch against misc-embedded.c adds an INTERACTIVE_CONSOLE
> #define to guard reading from console (causes unecessary delay in some
> situations).
> 
> Its an adaptation of misc.c's define, a difference being that platform
> headers define "NO_INTERACTIVE_CONSOLE" if required.
> 
> What do you think?

Please put a comment above the #ifndef stating where the define should
be.  But I have a feeling that's going to be somewhere under
arch/ppc/platforms/ or include/asm-ppc/ and I don't know if that's a
good idea...

I've got a vauge idea on how we can handle this a little bit more
cleanly, in the merge tree.

-- 
Tom Rini
http://gate.crashing.org/~trini/
