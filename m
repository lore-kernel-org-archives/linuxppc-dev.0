Return-Path: <dgibson@ozlabs.org>
Date: Wed, 18 Jul 2007 13:28:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 53/61] 82xx: Set NOT_COHERENT_CACHE on 8272 with PCI.
Message-ID: <20070718032857.GF18251@localhost.localdomain>
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
	<20070718013611.GY15238@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013611.GY15238@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 17, 2007 at 08:36:11PM -0500, Scott Wood wrote:
> I've seen significant network corruption on a PCI network
> card (e1000) with the mpc8272ads; the corruption went away
> when I set CONFIG_NOT_COHERENT_CACHE.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Hrm... I for one would be a lot more comfortable with this patch if
you had a theoretical explanation for why it's necessary, in addition
to the "seems to fix things".

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
