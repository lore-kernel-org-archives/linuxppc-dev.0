Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 0B603679FB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Apr 2006 22:18:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: problem with watchdog/reboot MPC5200
Date: Thu, 20 Apr 2006 14:06:49 +0200
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D9396B20F9@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: <jgeissel@gmx.net>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+joakim.tjernlund=3Dlumentis.se@ozlabs.
> org=20
> [mailto:linuxppc-embedded-bounces+joakim.tjernlund=3Dlumentis.se
> @ozlabs.org] On Behalf Of Arno Geissel
> Sent: 20 April 2006 13:35
> To: linuxppc-embedded@ozlabs.org
> Subject: Re: problem with watchdog/reboot MPC5200
>=20
> Jaap-Jan,
>=20
> I'm not booting from flash. The kernel is loaded using bootp and
> the rootfs is mounted over NFS. Flash is not needed for the boot
> process at all. Fact is, that the mpc5200 watchdog timer
> does not work, if I have written something to flash while runtime of
> the system. If I have not, the reboot, which uses the watchdog,
> performs OK.
> On the other hand I would expect that the MTD package should
> know how to handle an Intel Strataflash.
>=20
> Arno

I think you need to connect your flash reset pin to the MPC reset pin so
that
the CPU reset will reset the flash as well.

 Jocke
