Return-Path: <peter.fercher@scs.ch>
Received: from mail.scs.ch (mail.scs.ch [212.254.229.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19ACF682FB
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Sep 2005 23:52:16 +1000 (EST)
From: "Peter Fercher" <peter.fercher@scs.ch>
To: "'Josh Boyer'" <jwboyer@jdub.homelinux.org>
Date: Mon, 19 Sep 2005 15:51:24 +0200
Message-ID: <004f01c5bd21$394104e0$dbe5fed4@scsad.scs.ch>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1127137322.3211.0.camel@windu.rchland.ibm.com>
Cc: 'linux-ppc-embedded' <linuxppc-embedded@ozlabs.org>
Subject: RE: emac driver broken in 2.6.12.2 ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi,

when you read the output I have pasted there you can see the following =
(also
in my origninal mail)
eth0: IBM emac, MAC 00:00:00:00:00:00

eth0: Found Generic MII PHY (0x00)

eth1: IBM emac, MAC 00:00:00:00:00:00

eth1: Found Generic MII PHY (0x01)


I think that this MAC addresses are crap (sorry if not formulated =
clearly
enough for you ;)
am I wrong ?

cheers, peter

> -----Original Message-----
> From: Josh Boyer [mailto:jwboyer@jdub.homelinux.org]=20
> Sent: Montag, 19. September 2005 15:42
> To: Peter Fercher
> Cc: benh@kernel.crashing.org; linux-ppc-embedded
> Subject: Re: emac driver broken in 2.6.12.2 ?
>=20
>=20
> On Mon, 2005-09-19 at 15:37 +0200, Peter Fercher wrote:
> > hi,
> > =20
> > i have problems with the IBM EMAC with 2.6.12.2 (the driver worked=20
> > with 2.4.25) running on ppc405EP octobus board. Cross=20
> compiled on x86=20
> > using the eldk-3.1 toolchain
> > =20
> > any hints ?
>=20
> I think you'd need to be more explicit about what "problems"=20
> means. Hard to give hints with what you have here.
>=20
> josh
>=20
>=20
>=20

hi,
=20
i have problems with the IBM EMAC with 2.6.12.2 (the driver worked with
2.4.25)
running on ppc405EP octobus board. Cross compiled on x86 using the =
eldk-3.1
toolchain
=20
any hints ?
=20
emac: IBM EMAC Ethernet driver, version 2.0

Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org>

eth0: IBM emac, MAC 00:00:00:00:00:00

eth0: Found Generic MII PHY (0x00)

eth1: IBM emac, MAC 00:00:00:00:00:00

eth1: Found Generic MII PHY (0x01)

=20
cheers, peter
---------------------------------------------------------
Supercomputing Systems AG    phone:  +41 (0)43 456 16 31
Peter Fercher                fax:    +41 (0)43 456 16 10
Technoparkstrasse 1          email:  peter.fercher@scs.ch
CH-8005 Zuerich              url:    http://www.scs.ch=20
---------------------------------------------------------
 =20
