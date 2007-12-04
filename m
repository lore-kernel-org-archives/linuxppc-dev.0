Return-Path: <dgibson@ozlabs.org>
Date: Wed, 5 Dec 2007 09:20:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [FDT][PATCH] Print out the total size as part of ftdump
Message-ID: <20071204222047.GA5771@localhost.localdomain>
References: <Pine.LNX.4.64.0712041032580.29317@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0712041032580.29317@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 04, 2007 at 10:33:20AM -0600, Kumar Gala wrote:
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

You know, the whole batch of fprintf()s of header information in
dt_from_blob() are really just a debugging hack that uglifies dtc's
output.  The whole lot could be moved over to ftdump instead, which
is, after all, *supposed* to be a debugging hack.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
