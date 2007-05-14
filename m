Return-Path: <dgibson@ozlabs.org>
Date: Mon, 14 May 2007 10:40:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 10/13] powerpc: check cache coherency of kernel vs firmware
Message-ID: <20070514004014.GF6517@localhost.localdomain>
References: <20070512004605.GA2808@mag.az.mvista.com>
	<20070512005735.GJ3365@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070512005735.GJ3365@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 11, 2007 at 05:57:35PM -0700, Mark A. Greer wrote:
> 
> From: Dale Farnsworth <dale@farnsworth.org>
> 
> check_cache_coherency() verifies that the cache coherency setting of
> the kernel (CONFIG_NOT_COHERENT_CACHE) matches that left by the firmware,
> as indicated by coherency-off device tree property.

This looks really bogus.  If the firmware reports a coherency state,
then presumably there's some hardware switch to turn coherency on or
off.  In which case, can't the kernel just toggle that switch to
whatever's appropriate for it?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
