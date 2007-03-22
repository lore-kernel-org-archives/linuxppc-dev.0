Return-Path: <dgibson@ozlabs.org>
Date: Thu, 22 Mar 2007 14:02:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 2/4] powerpc: Add device tree utility functions to zImage
Message-ID: <20070322030258.GJ2295@localhost.localdomain>
References: <20070321063150.04BA4DDE9F@ozlabs.org>
	<200703211030.l2LAU2TE099295@sullivan.realtime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200703211030.l2LAU2TE099295@sullivan.realtime.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2007 at 09:03:02AM -0600, Milton Miller wrote:
> 
> Following your reply to Scott's comments about space in the xlate_reg
> thread, how about splitting the ones used in main.c which will always
> be included from the others that are more for device tree pokers.

Yeah, I guess.

> For that matter, your streamlining adds runtime overhead.  Why not
> cache the checked or created phandle?

Well, I made a judgeement that source simplicity was more valuable
than runtime speed.  However, in the second spin, I've reconsidered
and gotten rid of the dt_path_{get,set}prop functions entirely which
addresses both concerns above.

> Also, in dt_path_getprop, did you want to call finddevice instead of
> testing the function is not weak and undefined?

Yes.  Fixed now.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
