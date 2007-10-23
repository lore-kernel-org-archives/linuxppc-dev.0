Return-Path: <dgibson@ozlabs.org>
Date: Tue, 23 Oct 2007 10:38:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] DTC: Rewrite the propdata and propdataprefix rules.
Message-ID: <20071023003836.GH31839@localhost.localdomain>
References: <E1Ik5LQ-0000Ef-UF@jdl.com> <E1Ik5uH-0000bV-6C@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1Ik5uH-0000bV-6C@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 22, 2007 at 05:37:57PM -0500, Jon Loeliger wrote:
> So, like, the other day Jon Loeliger mumbled:
> > 
> > After staring at these two rules for a bit, and not quite
> > groking them, I rewrote them into something I think is a
> > bit clearer.  With any luck, it's the same language still.
> > 
> > Signed-off-by: Jon Loeliger <jdl@freescale.com>
> > ---
> > 
> > You be the judge too!
> 
> Yeah, so, I botched this one.  It's NOT the same
> language, so don't apply it or think about it at all...

Yeah, I remember finding the whole propdataprefix confusing myself.
But the form was suggested by someone (forgotten whom now), and I
never did figure out a better way of doing it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
