Return-Path: <wsa-dev@sang-engineering.com>
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQ8zZ73VGzF0V0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 22:56:42 +1100 (AEDT)
Date: Mon, 22 Jan 2018 12:49:48 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Frank Rowand <frowand.list@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 devicetree@vger.kernel.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-renesas-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/1] of: easier debugging for node life cycle issues
Message-ID: <20180122114948.mm5mg6zqw3hmjj4o@katana>
References: <20180121143117.19805-1-wsa+renesas@sang-engineering.com>
 <ac4f02e1-6d49-158a-4fb6-56ac0d474a44@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fhh3nixhltcc3znp"
In-Reply-To: <ac4f02e1-6d49-158a-4fb6-56ac0d474a44@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--fhh3nixhltcc3znp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Frank,

> Please go back and read the thread for version 1.  Simply resubmitting a
> forward port is ignoring that whole conversation.
>=20
> There is a lot of good info in that thread.  I certainly learned stuff in=
 it.

Yes, I did that and learned stuff, too. My summary of the discussion was:

- you mentioned some drawbacks you saw (like the mixture of trace output
  and printk output)
- most of them look like addressed to me? (e.g. Steven showed a way to redi=
rect
  printk to trace)
- you posted your version (which was, however, marked as "not user friendly"
  even by yourself)
- The discussion stalled over having two approaches

So, I thought reposting would be a good way of finding out if your
concerns were addressed in the discussion or not. If I overlooked
something, I am sorry for that. Still, my intention is to continue the
discussion, not to ignore it. Because as it stands, we don't have such a
debugging mechanism in place currently, and with people working with DT
overlays, I'd think it would be nice to have.

Kind regards,

   Wolfram


--fhh3nixhltcc3znp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlplz9wACgkQFA3kzBSg
KbYz6RAAp/gtGEbQ/RA5Au6LYgMZS3Z7pyPfII8DOZrkfOTPfEH6hNPOqIGl+BGB
jYRynJV1FIvgaamsJA1cHgm9VBGcb3i1a00ETZaRAxldAMMMG8r4HG4ZV0yvNMRJ
pQJmq5FmNy8QI0Gid02x1m56cLspDCvzlBOsNjIfhvQKRRGw4foYaJR3axvDPR4h
eIHA1H9BgpGuYVPHPxbe+KhUyofZVCjphXjH3gQ250gnNEQEueaBlAFKZMn4uMd7
rrI+j1XpGwqBFGt7/2to3KyKk8ajAj9CxT5kojJLWbnsVa759uOh1C3DlxLYy91d
vgjAHI47Bfzj+ZqqjYczpxmTS9JwtqdnzCDwBJnmPCrpTfl2MQWu+N1V4waD+TRe
SJZb1597Bt62MesJTWkjsfPR1y05T38x/DwEDagBddy80RR/zXby/SIMlouOMNQd
2dRo+HrhfXVa6ShDeVHB/KMgdpByQpYqGopshqGbmHOrPh0anwClTXbgNAvHAxEh
4bLh5ukHx99wkMDD1hob1na4CvnetvvKaovrmeHF773eGY6k4K+hcnWo7xYzcN3H
/BTfwaBU3+W9XAcPW9LP0oBHaIF3UDoRfTU3go5gGLDJWIFgyNlNVIwr00TVOZBJ
upw2ZAN+YLK69lr7T7XK5cSpdVc7VaZngCpmttjWn8tosVKe1Bc=
=I+Fc
-----END PGP SIGNATURE-----

--fhh3nixhltcc3znp--
