Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 43653DE2C0
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 04:23:35 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: OF compatible MTD platform RAM driver ?
Date: Tue, 25 Mar 2008 18:23:26 +0100
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<200803251744.46001.laurentp@cse-semaphore.com>
	<47E93010.5090904@ru.mvista.com>
In-Reply-To: <47E93010.5090904@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1966428.EamxGzEXNU";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803251823.32039.laurentp@cse-semaphore.com>
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1966428.EamxGzEXNU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 25 March 2008 18:02, Sergei Shtylyov wrote:
> Laurent Pinchart wrote:
>=20
> > > Heh, there was a whole company against mentioning "mtd" when we start=
ed=20
> > > working on this (of course, the first idea was to call the flash devi=
ce
> > > type "mtd"). I don't think "mtd" looks good here -- I'd suggest
> > > "flash-ram" (if this is just a linearly mapped NVRAM).
>=20
> > I'm fine with "flash-ram" (even thought it looks a bit weird). I'll
> > prepare a patch.
>=20
> Yeah. I forgeot that "flash" means EEPROM. Actually, the main facts about=
=20
> the NVRAM that I'd want to be stated in the "compatible" property is that
> it's  non-volatile and directly/lineraly mapped... Just "nvram" doesn't s=
eem=20
> enopugh, maybe "linear-nvram" is.

Direct mapping is a hard requirement for the nvram if we want to use it wit=
h=20
the MTD subsystem. Regarding non-volatility nothing prevents a user from=20
using a volatile RAM as an MTD device, but there's little point in doing so=
=2E=20
Would it be acceptable for the "linear-nvram" specification not to include=
=20
volatile RAM ? ROM chips would be excluded too. Is that an issue ?

> And we can specify "device_type" of "nvram" indeed (and #size).=20

I suppose you meant #bytes.

What about sub-partitions support ? Nothing prevents RAM-based MTD devices=
=20
from being partioned. Would it be acceptable to reference the CFI/JEDEC fla=
sh=20
section in Documentation/powerpc/booting-without-of.txt in the description =
of=20
the nvram node ?

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1966428.EamxGzEXNU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH6TUU8y9gWxC9vpcRAnKcAKC3rEmYzaH8/rq6Ye10bwpRtw8IrACfVZVE
1o0asnKZlpZJ+h2OmFZTkvo=
=ngU1
-----END PGP SIGNATURE-----

--nextPart1966428.EamxGzEXNU--
