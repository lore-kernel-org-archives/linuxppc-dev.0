Return-Path: <mbuesch@freenet.de>
Received: from mout0.freenet.de (mout0.freenet.de [194.97.50.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6EDC26861E
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Oct 2005 20:00:59 +1100 (EST)
From: Michael Buesch <mbuesch@freenet.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 30 Oct 2005 09:47:21 +0100
References: <1130645036.29054.229.camel@gaston>
In-Reply-To: <1130645036.29054.229.camel@gaston>
MIME-Version: 1.0
Message-Id: <200510300947.21917.mbuesch@freenet.de>
Content-Type: multipart/signed; boundary="nextPart3796900.1S1bxy24Lc";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, bcm43xx-dev@lists.berlios.de
Subject: Re: [Bcm43xx-dev] 30 bits DMA and ppc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart3796900.1S1bxy24Lc
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 30 October 2005 05:03, Benjamin Herrenschmidt wrote:
[snip]
> However, the above would require arch specific hacks, and would only
> work for one card in the system (too bad if you plug a cardbus one).
[snap]

I think we should not need to modify the driver.
Drivers already set the DMA mask. As far as I can see, this mask
is currently (mostly) ignored on PPC and i386 (at least).
As far as I can see, PPC ignores it completely and i386 allocates in the
GFP_DMA region, if DMA is limited.
So I would say, it should be possible to use this mask
with some bounce buffers, as you suggested. That sounds like a good
solution to me. It's worth a try.

=2D-=20
Greetings Michael.

--nextPart3796900.1S1bxy24Lc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBDZIiZlb09HEdWDKgRApNcAKCyDcws0GUthHCFyd4MKoxCQ5DM4wCeOki4
aoHm7aef5ttnaT158aDBDvw=
=63fH
-----END PGP SIGNATURE-----

--nextPart3796900.1S1bxy24Lc--
