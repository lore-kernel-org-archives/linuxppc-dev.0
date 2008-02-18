Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Remove no longer used code from
	fdt_node_offset_by_compatible()
In-Reply-To: Your message of "Mon, 18 Feb 2008 18:09:04 +1100."
	<20080218070904.GJ29975@localhost.localdomain>
References: <20080218070904.GJ29975@localhost.localdomain> 
Date: Mon, 18 Feb 2008 08:29:57 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JR70H-0001Uy-T7@jdl.com>
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
> Since fdt_node_offset_by_compatible() was converted to the new
> fdt_next_node() iterator, a chunk of initialization code became
> redundant, but was not removed by oversight.  This patch cleans it up.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
