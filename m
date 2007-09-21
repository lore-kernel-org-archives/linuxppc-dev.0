Return-Path: <dgibson@ozlabs.org>
Date: Fri, 21 Sep 2007 10:49:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] bootwrapper: Factor out dt_set_mac_address().
Message-ID: <20070921004906.GA4124@localhost.localdomain>
References: <20070920220615.GA28860@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070920220615.GA28860@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 20, 2007 at 05:06:15PM -0500, Scott Wood wrote:
> This allows callers to set addresses one at a time when that would be more
> convenient.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Um... I feel bad whinging about such a tiny nit, but...

> +void dt_set_mac_address(u32 index, const u8 *addr)

.. I'd prefer it was called dt_fixup_mac_address() to match the other
functions.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
