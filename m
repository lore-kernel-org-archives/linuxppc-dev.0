Return-Path: <dgibson@ozlabs.org>
Date: Wed, 24 Oct 2007 09:23:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH 01/11] [POWERPC] Add 'machine: ...' line to common
	show_cpuinfo()
Message-ID: <20071023232303.GA10595@localhost.localdomain>
References: <20071023231302.29359.27417.stgit@hekate.izotz.org>
	<20071023231309.29359.20887.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071023231309.29359.20887.stgit@hekate.izotz.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 24, 2007 at 01:13:09AM +0200, Marian Balakowicz wrote:
> Print out '/model' property as a machine name in generic
> show_cpuinfo() routine.

There's no such thing as /model; subnodes and properties have a
different namespace, so the root node, /, has a property named
'model'.

Yes, it's clear what you mean in this context, but it's a bad habit to
get into.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
