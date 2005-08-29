Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <1125089709.32488.35.camel@cashmere.sps.mot.com>
References: <1123023575.2614.25.camel@cashmere.sps.mot.com>
	<688ba2276de281a9473b030a16a514c0@embeddededge.com>
	<20050805174705.731ffa05.sfr@canb.auug.org.au>
	<200508051353.23750.arnd@arndb.de>
	<20050806005941.5d1fe432.sfr@canb.auug.org.au>
	<1125089709.32488.35.camel@cashmere.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <7d30f9ea7e93320d569a60c90f179ba5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Mon, 29 Aug 2005 17:44:34 +0200
To: Jon Loeliger <jdl@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] 1/2 Start header file merger (Was: Re: Beginning Merger
	Patch)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Anyone care to take a semi-authoritative stand on what
> symbol to use to distinguish 32/64-bit-ness in the
> include files?

It depends on what you are testing for.

Sometimes __LP64__ would be best (when you want to know
the size of pointers etc.), sometimes __powerpc64__ (when
you need to know the available instruction set), and
I'm sure there are cases where you should use a different
symbol altogether, because you are testing something else.


Segher
