Return-Path: <dgibson@ozlabs.org>
Date: Fri, 28 Mar 2008 10:56:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] [POWERPC] 4xx: Create common ppc4xx_reset_system() in
	ppc4xx_soc.c
Message-ID: <20080327235618.GA16141@localhost.localdomain>
References: <1206629011-28821-1-git-send-email-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1206629011-28821-1-git-send-email-sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 27, 2008 at 03:43:31PM +0100, Stefan Roese wrote:
> This patch creates a common system reset routine for all 40x and 44x
> systems. Previously only a 44x routine existed. But since this system
> reset via the debug control register is common for 40x and 44x let's
> share this code for all those platforms in ppc4xx_soc.c.

Well... they're sort of common.  The source looks the same, but the
SPR number of DBCR0 is different on 40x and 44x, which is a
potentially serious gotcha.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
