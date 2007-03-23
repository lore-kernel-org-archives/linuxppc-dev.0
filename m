Return-Path: <dgibson@ozlabs.org>
Date: Fri, 23 Mar 2007 14:31:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Remove bogus errors from check_chosen.
Message-ID: <20070323033158.GG28006@localhost.localdomain>
References: <20070322161109.GA20512@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070322161109.GA20512@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 22, 2007 at 11:11:09AM -0500, Scott Wood wrote:
> It is not an error for /chosen (or any of its children) to be missing.
> 
> It is not a requirement that the output of dtc be a complete, valid
> device tree, as it may be intended that the dtb be passed through boot
> code that will complete it.  Thus, do not complain.

I'm not 100% comfortable with this patch; I'd like for dtc to have the
facility to do more-or-less complete tree validation.  However, as you
point out it's really irritating right now, so I think removing the
check is the best approach for now.  If I ever get around to
implementing a decent error/warning handling framework for dtc, then
more complete checking can go back in under the right circumstances.
 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
