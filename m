Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 57206DE29C
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:08:04 +1100 (EST)
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 37B4A368002
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:08:04 +1100 (EST)
Date: Fri, 7 Dec 2007 02:07:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: Powerpc PCI cleanups (mainly iSeries)
Message-Id: <20071207020726.8c0ea12b.sfr@canb.auug.org.au>
In-Reply-To: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__7_Dec_2007_02_07_26_+1100_M9IGil7wc31FWw2R"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__7_Dec_2007_02_07_26_+1100_M9IGil7wc31FWw2R
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Dec 2007 18:00:45 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> I started out looking for ways to remove our dependencies on pci_dn and
> got sidetracked into clening up the iSeries PCI code.  The intention of
> the following set of patches is that there be no semantic changes
> (mostly).

Some of these will clearly conflict with Benh's PCI work.  We will sot
that out between us.  :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__7_Dec_2007_02_07_26_+1100_M9IGil7wc31FWw2R
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQFHWBA0TgG2atn1QN8RAuf8AJUbmu9cFSJvAEuTeJ/zfKYhsoqLAKCXsRiW
G1Nh8GQmKTkNWzocR7BOMg==
=2Zms
-----END PGP SIGNATURE-----

--Signature=_Fri__7_Dec_2007_02_07_26_+1100_M9IGil7wc31FWw2R--
