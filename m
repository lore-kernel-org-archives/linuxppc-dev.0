Return-Path: <dgibson@ozlabs.org>
Date: Fri, 30 May 2008 11:01:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 1/2] update crypto node definition and device tree
	instances
Message-ID: <20080530010117.GA26816@yookeroo.seuss>
References: <20080529141246.b9cea683.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080529141246.b9cea683.kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 29, 2008 at 02:12:46PM -0500, Kim Phillips wrote:
> delete obsolete device-type property, delete model property
> (use compatible property instead), prepend "fsl," to Freescale
> specific properties. Add nodes to device trees that are missing them,
> and fix broken property values in other trees.

Hurrah, that broken binding has finally been fixed.

> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
