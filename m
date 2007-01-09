Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 85F9DDDDED
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 19:13:30 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: mpc83xx_restart() buggy
Date: Tue, 9 Jan 2007 09:13:20 +0100
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D939BF3178@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Scott Wood" <scottwood@freescale.com>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From:=20
> linuxppc-dev-bounces+joakim.tjernlund=3Dtransmode.se@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+joakim.tjernlund=3Dtransmode.se@ozl
> abs.org] On Behalf Of Scott Wood
> Sent: 30 December 2006 00:04
> To: Kumar Gala
> Cc: Tjernlund; 'linuxppc-dev'
> Subject: Re: mpc83xx_restart() buggy
>=20
> Kumar Gala wrote:
> > On Dec 27, 2006, at 6:45 PM, Tjernlund wrote:
> >>mpc83xx_restart() uses ioremap(), which doesn't like
> >>beeing called while in IRQ context.
> >>
> >>Calling mpc83xx_restart() in IRQ context yields OOPS
> >>which calls mpc83xx_restart() again and the loop never
> >>termintes.
> >=20
> > This is interesting, I know I've seen restart work properly w/o an =20
> > oops.  How are you causing the restart?
>=20
> sysrq-b triggers it, as probably does crashing from an=20
> interrupt handler=20
> with panic_timeout nonzero.  You'll need CONFIG_DEBUG_SPINLOCK_SLEEP=20
> turned on, of course.
>=20
> -Scott

Any chance for a fix soon?

 Jocke
