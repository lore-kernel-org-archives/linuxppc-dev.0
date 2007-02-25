Return-Path: <dgibson@ozlabs.org>
Date: Mon, 26 Feb 2007 10:57:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [0/14] Ebony support, 2nd spin
Message-ID: <20070225235748.GA29826@localhost.localdomain>
References: <20070220020837.GF17818@localhost.localdomain>
	<200702201516.25160.arnd@arndb.de>
	<20070221003558.GJ10231@localhost.localdomain>
	<200702211006.58565.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200702211006.58565.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 21, 2007 at 10:06:58AM +0100, Arnd Bergmann wrote:
> On Wednesday 21 February 2007 01:35, David Gibson wrote:
> > Err.. no.  On my system legacy_serial doesn't touch the ports, but I'm
> > getting console output via of_serial just fine.  The console is
> > initialized rather later than would be ideal, but it works.
> > 
> > I know that BenH has expressed the strong preference that
> > legacy_serial should be reverted to only handling legacy ISA ports,
> > not SoC and other hardwired ports.
> 
> Ok, my impression on this was that of_serial is the right solution
> in general, but it often gets initialized too late to debug some
> of the interesting parts of the boot sequence.
> 
> Unless we take handling of soc serial ports completely out of
> legacy_serial, I think it should handle ebony just like the other
> boards.

Well, Ben has said to me that he'd like to remove handling of SoC
serial ports (indeed everything excepy legacy ISA) from
legacy_serial.c.


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
