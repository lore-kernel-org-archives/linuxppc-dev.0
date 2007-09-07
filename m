Return-Path: <dgibson@ozlabs.org>
Date: Fri, 7 Sep 2007 10:51:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 06/10] bootwrapper: Move strncmp() from flatdevtree_env.h
	to string.S/string.h.
Message-ID: <20070907005131.GF26079@localhost.localdomain>
References: <20070905192001.GA32049@ld0162-tx32.am.freescale.net>
	<20070905192114.GF32113@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905192114.GF32113@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2007 at 02:21:14PM -0500, Scott Wood wrote:
> It will be needed for PlanetCore firmware support.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

I still have a patch that already does this, plus strchr() as well,
pending...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
