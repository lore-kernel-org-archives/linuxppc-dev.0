Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <ffec644f8c4f3bc32922882631c0da3e@freescale.com>
References: <ffec644f8c4f3bc32922882631c0da3e@freescale.com>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 08:21:50 +1000
Message-Id: <1112048510.5410.60.camel@gaston>
Mime-Version: 1.0
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
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

On Mon, 2005-03-28 at 10:44 -0600, Kumar Gala wrote:
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

I used to have argD, arg1, arg2 but since everything else was "compact",
I now tend to adapt to everything else ;)

Ben.
