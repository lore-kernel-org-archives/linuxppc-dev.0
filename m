Return-Path: <dgibson@ozlabs.org>
Date: Wed, 18 Jul 2007 12:01:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 03/11] dtc: complain about unparsed digits in cell lists
Message-ID: <20070718020104.GD18251@localhost.localdomain>
References: <dtc-5-00.miltonm@bga.com> <dtc-5-03.miltonm@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dtc-5-03.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 07, 2007 at 01:18:48AM -0500, Milton Miller wrote:
> Check that strtoul() parsed the complete string.
> 
> As with the number overflow case, write a non-fatal error
> message to stdout.
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>
> --- 
> I saw the FIXME and knew how to fix it.  
> 
> I think the severity should be higher, but opted for the
> detailed error message compared to the fixed string of
> yyerror() and its immediate termination of parsing.

Yeah, it should really result in a fatal error, but delayed until
after parsing and other error checking is complete.  Yet another one
for the Great Error Handling Rewrite.  This is an improvement for now.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
