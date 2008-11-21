Return-Path: <dgibson@ozlabs.org>
Date: Fri, 21 Nov 2008 18:29:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Krill <ben@codiert.org>
Subject: Re: [PATCH] Add support for the nwp serial device
Message-ID: <20081121072928.GA14179@yookeroo.seuss>
References: <200811201501.24000.arnd@arndb.de>
	<20081121003545.GC13049@yookeroo.seuss>
	<20081121072101.GP24487@codiert.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081121072101.GP24487@codiert.org>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 21, 2008 at 08:21:02AM +0100, Benjamin Krill wrote:
> * David Gibson | 2008-11-21 11:35:45 [+1100]:
> 
> >
> >Uh.. registers as port number 84??  What's this random number about?
> >
> It's just the next free number in serial_core.h.

Ah, right, sorry, those are type codes.  Thought you meant it was
registering as /dev/ttyS84 or something similarly strange.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
