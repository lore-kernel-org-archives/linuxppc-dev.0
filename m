Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 2E1F967BE7
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 09:51:42 +1100 (EST)
Date: Tue, 12 Dec 2006 16:51:39 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
Message-Id: <20061212165139.575d059a.kim.phillips@freescale.com>
In-Reply-To: <1165963479.11914.98.camel@localhost.localdomain>
References: <20061208190758.6cee088f.kim.phillips@freescale.com>
	<1165648490.1103.117.camel@localhost.localdomain>
	<91EF8E0D-06BC-47FD-89E6-6350430946F9@kernel.crashing.org>
	<20061211155155.26868ca6.kim.phillips@freescale.com>
	<A1A95A77-B86C-41CF-87DC-58CD63843CE3@kernel.crashing.org>
	<20061211201055.21031c9b.kim.phillips@freescale.com>
	<1165890570.11914.5.camel@localhost.localdomain>
	<457F1F6E.4020502@freescale.com>
	<1165960058.11914.72.camel@localhost.localdomain>
	<7152860A-27A3-4C08-B6A5-DFA57A63ACED@kernel.crashing.org>
	<20061212162416.06f0dd76.kim.phillips@freescale.com>
	<A2576248-6DF4-44BE-99D2-0D8477865B17@kernel.crashing.org>
	<20061212163803.01d9c63e.kim.phillips@freescale.com>
	<1165963479.11914.98.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 13 Dec 2006 09:44:38 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > well it depends on what you do with the _probe()s.  If you have multiple define_machine definitions built in, the generic probe will always succeed to match on the first machine probe_machine() tests, which may or may not be the machine it's currently running on.
> 
> Which is an argument for _NOT_ doing a generic probe !
> 
> Ben.
> 
> 
correct, not doing a generic probe with a file per board (if all it has is the ppc_md/ define_machine() in it), is bad.  It needs to be accompanied with its _probe().  Isn't that what the question was?

Kim
