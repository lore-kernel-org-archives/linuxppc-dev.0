Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [dtc] Get rid of libdt.c 
In-Reply-To: Your message of "Wed, 14 Mar 2007 11:06:23 +1100."
	<20070314000623.GE25514@localhost.localdomain>
References: <20070314000623.GE25514@localhost.localdomain> 
Date: Wed, 14 Mar 2007 15:42:38 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HRaIw-0000PN-T3@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> libdt.c was an attempt at creating a device tree handling library
> within the dtc codebase.  However, it was never even close to
> completion, and is entirely obsoleted by it's spiritual descendent,
> libfdt (currently a separate package).  This patch, therefore, removes
> libdt.c entirely, along with its only reference in the Makefile, an
> unused variable.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl
