Return-Path: <mmporter@cox.net>
Received: from fed1rmmtai09.cox.net (fed1rmmtai09.cox.net [68.230.241.50])
	by ozlabs.org (Postfix) with ESMTP id E658167A46
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Mar 2005 04:24:59 +1000 (EST)
Date: Mon, 28 Mar 2005 10:22:03 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050328102203.C15491@cox.net>
References: <ffec644f8c4f3bc32922882631c0da3e@freescale.com>
	<20050328165610.GG25923@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050328165610.GG25923@smtp.west.cox.net>;
	from trini@kernel.crashing.org on Mon, Mar 28, 2005 at 09:56:11AM
	-0700
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: ASM formatting rules?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 28, 2005 at 09:56:11AM -0700, Tom Rini wrote:
> On Mon, Mar 28, 2005 at 10:44:17AM -0600, Kumar Gala wrote:
> > Guys,
> > 
> > While this is not overly important to me, I was wondering if we had any 
> > rules related to formatting of assembly files.  We seem to have code 
> > formatted with and without spaces in the args.
> > 
> > I'm assuming something like this (w/o spaces):
> > 
> > <TAB>insn<TAB>argD,arg1,arg2
> > 
> > is what we want?  Just trying to get a rule documented going forward.
> 
> My preference is for spaces after each , just because it makes it
> visually clearer (and I don't always have instant mental insn->#args
> mental mapping :)).

As long as there is <TAG>insn<TAB>, I don't have strong feelings
about the arg spacing.  I feel that spaces between args really
don't enhance readability (why I have none between args in
head_44x.S) but I can live with them.

I think this is a good idea to get some consistency throughout
ppc32 asm.

-Matt
