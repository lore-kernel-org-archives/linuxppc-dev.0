Return-Path: <dgibson@ozlabs.org>
Date: Tue, 13 Mar 2007 12:41:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 04/19] bootwrapper: Rename ft_node_add() to
	ft_get_phandle().
Message-ID: <20070313014147.GG29506@localhost.localdomain>
References: <20070312204144.GD28545@ld0162-tx32.am.freescale.net>
	<20070312223241.GC31268@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070312223241.GC31268@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 12, 2007 at 03:32:41PM -0700, Mark A. Greer wrote:
> On Mon, Mar 12, 2007 at 02:41:44PM -0600, Scott Wood wrote:
> > This name better reflects what the function does, which is to
> > look up the phandle for an internal node pointer, and add it to the
> > internal pointer to phandle table if not found.
> > 
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> 
> Acked-by: Mark A. Greer <mgreer@mvista.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
