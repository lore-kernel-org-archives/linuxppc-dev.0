Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id C310867C3B
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 19:59:53 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 25 Aug 2006 11:59:46 +0200
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: emulate power5 popcntb instruction
Message-ID: <20060825095946.GA8576@iram.es>
References: <1155840829.9659.16.camel@farscape.rchland.ibm.com>
	<200608182105.45264.arnd@arndb.de>
	<50883.84.105.60.119.1156014614.squirrel@gate.crashing.org>
	<200608192219.03178.arnd@arndb.de>
	<37280.84.105.60.119.1156030372.squirrel@gate.crashing.org>
	<1156190965.9659.41.camel@farscape.rchland.ibm.com>
	<17645.18647.720814.903612@cargo.ozlabs.ibm.com>
	<9FF8F72E-5990-4AED-A826-9E1C9C889DB6@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9FF8F72E-5990-4AED-A826-9E1C9C889DB6@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	segher@gate.crashing.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 24, 2006 at 05:53:56PM +0200, Segher Boessenkool wrote:
> > Also it would be really nice if you could figure out a way to
> > avoid doing the unnecessary 64-bit logical operations on 32-bit
> > machines
> 
> Like I asked before -- should we run this emulation on 32-bit
> machines at all?  The instruction only exists in the 64-bit
> architecture after all.

It's useless for now, but I would not be surprised if someone 
creates a new 32 bit processor which includes this instruction.

	Gabriel
