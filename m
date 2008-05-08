Return-Path: <dgibson@ozlabs.org>
Date: Thu, 8 May 2008 10:18:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [POWERPC] Xilinx: add compatibility for IBM
	coreconnect busses.
Message-ID: <20080508001850.GB5156@yookeroo.seuss>
References: <20080507204734.574B6185804E@mail138-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080507204734.574B6185804E@mail138-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 07, 2008 at 01:47:31PM -0700, Stephen Neuendorffer wrote:
> The IBM coreconnect names are pretty well defined, it appears.  In
> addition, the Xilinx versions of these IPs seem to be proliferating.
> Hence, in the future let's prefer to use the standard names.  I've
> left the old names in for some backward compatibility for existing
> device trees.
> 
> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

If you're talking about future trees, can't you just slap "simple-bus"
on them avoid this monster id table?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
