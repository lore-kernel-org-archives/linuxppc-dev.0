Return-Path: <dgibson@ozlabs.org>
Date: Thu, 30 Aug 2007 10:31:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/9] bootwrapper: Move strncmp() from flatdevtree_env.h to
	string.S/string.h.
Message-ID: <20070830003130.GD21072@localhost.localdomain>
References: <20070829164534.GA31585@ld0162-tx32.am.freescale.net>
	<20070829164735.GC31640@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070829164735.GC31640@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 29, 2007 at 11:47:35AM -0500, Scott Wood wrote:
> It will be needed for PlanetCore firmware support.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

This one is obsoleted by my recent patch which moves both strncmp()
and strchr() to string.S.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
