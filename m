Return-Path: <dgibson@ozlabs.org>
Date: Wed, 22 Oct 2008 11:09:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Mike Ditto <mditto@consentry.com>
Subject: Re: [PATCH] powerpc: Add del_node function to allow early boot
	code to prune inapplicable devices.
Message-ID: <20081022000917.GE8477@yookeroo.seuss>
References: <48F7E1E6.4040701@consentry.com>
	<20081017012604.GA22213@yookeroo.seuss> <48FE4A6D.5@consentry.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48FE4A6D.5@consentry.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 21, 2008 at 02:32:29PM -0700, Mike Ditto wrote:
> Reposting in proper format...
> 
> Some platforms have variants that can share most of a flat device tree but need
> a few devices selectively pruned at boot time.  This adds del_node() to ops.h
> to allow access to the existing fdt_del_node().
> 
> Signed-off-by: Mike Ditto <mditto@consentry.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
