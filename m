Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 Mar 2007 14:30:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 1/7] boot: use a common zImage rule
Message-ID: <20070320033039.GA21124@localhost.localdomain>
References: <boot-00.miltonm@bga.com> <boot-01.miltonm@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <boot-01.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 19, 2007 at 02:58:07PM -0600, Milton Miller wrote:
> Before the plethora of platforms gets any worse, establish a common
> rule to invoke the wrapper for any platform.  Add arguments to
> the rule for initrd, dts, dtb, etc.   Show example usage with initrd.
> 
> For now, uImage and zImage*ps3 are special.  Hopefully ps3 will join
> the party.
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>
> --- 
> One reviewer pointed out the explicit exception rule are now seperated
> from the generic rule.  While the rule needs to go after the image-
> assignment, that code could be moved up.

The problem with this patch is that while the wrap command can take a
dts or dtb, there's no way to specify which should be used with each
target.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
