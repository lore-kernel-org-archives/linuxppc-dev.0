Return-Path: <amodra@bigpond.net.au>
Received: from omta03sl.mx.bigpond.com (omta03sl.mx.bigpond.com
	[144.140.92.155]) by ozlabs.org (Postfix) with ESMTP id F3262DDEEC
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 20:57:42 +1000 (EST)
Date: Sat, 30 Jun 2007 20:27:41 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull from 'for_paulus' branch
Message-ID: <20070630105741.GD497@bubble.grove.modra.org>
References: <Pine.LNX.4.64.0706290023590.15748@blarg.am.freescale.net>
	<18052.42546.78964.805791@cargo.ozlabs.ibm.com>
	<jelke2ss3n.fsf@sykes.suse.de>
	<18053.65260.136499.154352@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18053.65260.136499.154352@cargo.ozlabs.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jun 30, 2007 at 04:57:48PM +1000, Paul Mackerras wrote:
> Andreas Schwab writes:
> 
> > The assembler should be called with -a64, which has the effect of
> > defaulting to -mppc64.
> 
> Yes, the assembler is called with -a64, but that doesn't appear to
> have the effect of defaulting to -mppc64.
> 
> [Alan: this thread is about the fact that compiling C code with "gcc
> -m64 -mcpu=powerpc64" will give assembler errors, complaining about
> instructions like sldi, whereas compiling with "gcc -m64" doesn't.]

Eh?  For a long time, powerpc gcc has passed "-many" to the assembler,
which should avoid this sort of problem.  Broken toolchain, I'd say.

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
