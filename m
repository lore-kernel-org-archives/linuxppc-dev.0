Return-Path: <dgibson@ozlabs.org>
Date: Wed, 21 Feb 2007 11:20:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/14] Early serial debug support for PPC44x
Message-ID: <20070221002032.GD10231@localhost.localdomain>
References: <20070220021235.96911DDD0B@ozlabs.org>
	<0d575e298627bedc007707a24b20491d@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0d575e298627bedc007707a24b20491d@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 20, 2007 at 02:26:05PM +0100, Segher Boessenkool wrote:
> > +config PPC_EARLY_DEBUG_44x
> > +	bool "Early serial debugging for IBM 44x CPUs"
> 
> Change this to IBM/AMCC 44x, like the patch description
> says?

Done.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
