Return-Path: <dgibson@ozlabs.org>
Date: Mon, 17 Dec 2007 16:43:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] wrapper: Treat NULL as root node in devp_offset;
	add devp_offset_find().
Message-ID: <20071217054358.GF3477@localhost.localdomain>
References: <20071211212305.GB3661@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071211212305.GB3661@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 11, 2007 at 03:23:05PM -0600, Scott Wood wrote:
> Many operations, as currently used in the wrapper, assume they can
> pass NULL and have it be treated as the root node.  However, libfdt-wrapper
> converts NULL to -1, which is only appropriate when searching for nodes,
> and will cause an error otherwise.

Hrm.  AFAICT "many" in this case, means three (being calls to
create_node() in devtree.c, main.c and planetcore.c).

Still I guess this patch is ok for now.  I futgure I'd like to shrink
the wrapper down and make the general interface be as close as
possible to the native libfdt interface.

> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
