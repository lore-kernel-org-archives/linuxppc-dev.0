Return-Path: <trini@kernel.crashing.org>
Date: Mon, 28 Mar 2005 09:56:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050328165610.GG25923@smtp.west.cox.net>
References: <ffec644f8c4f3bc32922882631c0da3e@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ffec644f8c4f3bc32922882631c0da3e@freescale.com>
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

On Mon, Mar 28, 2005 at 10:44:17AM -0600, Kumar Gala wrote:
> Guys,
> 
> While this is not overly important to me, I was wondering if we had any 
> rules related to formatting of assembly files.  We seem to have code 
> formatted with and without spaces in the args.
> 
> I'm assuming something like this (w/o spaces):
> 
> <TAB>insn<TAB>argD,arg1,arg2
> 
> is what we want?  Just trying to get a rule documented going forward.

My preference is for spaces after each , just because it makes it
visually clearer (and I don't always have instant mental insn->#args
mental mapping :)).

-- 
Tom Rini
http://gate.crashing.org/~trini/
