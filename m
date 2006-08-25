Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17646.62392.318654.762210@cargo.ozlabs.ibm.com>
Date: Fri, 25 Aug 2006 22:57:28 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: emulate power5 popcntb instruction
In-Reply-To: <9FF8F72E-5990-4AED-A826-9E1C9C889DB6@kernel.crashing.org>
References: <1155840829.9659.16.camel@farscape.rchland.ibm.com>
	<200608182105.45264.arnd@arndb.de>
	<50883.84.105.60.119.1156014614.squirrel@gate.crashing.org>
	<200608192219.03178.arnd@arndb.de>
	<37280.84.105.60.119.1156030372.squirrel@gate.crashing.org>
	<1156190965.9659.41.camel@farscape.rchland.ibm.com>
	<17645.18647.720814.903612@cargo.ozlabs.ibm.com>
	<9FF8F72E-5990-4AED-A826-9E1C9C889DB6@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de, segher@gate.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> Like I asked before -- should we run this emulation on 32-bit
> machines at all?  The instruction only exists in the 64-bit
> architecture after all.

It could be argued either way, but on the whole I would prefer to
minimize the number of things which could cause a 32-bit program that
runs quite happily on a 64-bit CPU to fail on a 32-bit CPU...

Paul.
