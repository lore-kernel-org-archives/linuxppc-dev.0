Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2FB6F1A0003
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 21:31:52 +1000 (EST)
Date: Thu, 17 Jul 2014 12:31:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Heiko Schocher <hs@denx.de>
Message-ID: <20140717113129.GU17528@sirena.org.uk>
References: <53C79351.2080406@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0WzQiIesntPPsVaS"
In-Reply-To: <53C79351.2080406@denx.de>
Subject: Re: spi, spi_fsl-spi.c not working?
Cc: Andreas Larsson <andreas@gaisler.com>, linux-spi@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--0WzQiIesntPPsVaS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 17, 2014 at 11:11:45AM +0200, Heiko Schocher wrote:

> Is it maybe the missing "support for the SPI subsystem's queue SPI messages"?

It shouldn't be that, that's still optional (sadly).

--0WzQiIesntPPsVaS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTx7QOAAoJELSic+t+oim9ZaUP/RVeH0pegoL7anagNM4PjTXo
RZEs6JTQRC4wm2aj7kewmwGTGvNTwOKBPKVDVGeKNuDokwoSTIVIBbyL3UeexRmA
0yiMwQ7lWPKqZtx/d+DOxXC/zY4P3D+0o+kqJ1Gh4ulAqc95kN9U2R3/kLqE2by3
P9PEeqqFBvd05NfOhjIDbC04Up53njdbFUStzXbGE/voOTWQf32j1TLziKZslb4p
Tr1YIMfJTX4tNTWMB+MUZyNxhg6ogcU9ENIEZBhiZNvGapzY5DclfRglb3lOwrzK
J75JxyxXIGTAbjzBmjYUAgL2rGwb73FVf3HgkRPxva5LrEtoBgKNtKU4k9GEqIw4
y7MvZ4Eps1CYkxTOMlWPxPvMapInhFAA7i6//ok4ZDp4JEdx+sEtsMfqg1xoNMNo
HyMX7D/KG6J36UV2K+VM8LteSo433alW9H4rfKBWB5fCAzK8aIpVfgsLThxwqG+3
e/VG4bbJ2cPNlHS4mUBZokiFS8UNnQ7X/E5fyDYfPsPK1eOm+cUevLjD6l8Qwaov
4TO9iD37SFdJINgrQiVnLAQAOx2nS9qUBK0+szzSXrMQzGglnF64qBblS03zP7ds
SnG72+WcMa38nA35UdDh0KlNdPTDHpJKTL1OsgBFrFm1HamYajailj3yQHFqO2A4
oJw5Y/BokJC3BnUV+r3u
=1jxs
-----END PGP SIGNATURE-----

--0WzQiIesntPPsVaS--
