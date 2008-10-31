Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 839ADDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 18:49:28 +1100 (EST)
Received: from ash.ozlabs.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 976CF368004
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 18:49:26 +1100 (EST)
Date: Fri, 31 Oct 2008 18:49:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: CONFIG_PCI_LEGACY and defconfigs
Message-Id: <20081031184919.fd7c0dd3.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__31_Oct_2008_18_49_19_+1100_wUqHAs0bZPXBfziz"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__31_Oct_2008_18_49_19_+1100_wUqHAs0bZPXBfziz
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

As you are updating the defconfigs, please have a look at removing
CONFIG_PCI_LEGACY.  It should be able to be removed from all powerpc
defconfigs with little, if any effect, I think.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__31_Oct_2008_18_49_19_+1100_wUqHAs0bZPXBfziz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkKuH8ACgkQjjKRsyhoI8zOTwCgh/Cb7qWD7uO2bN0gim7RzAKK
+FUAoK4274EsPAO/xC/15hFIFB71B6Pg
=twJU
-----END PGP SIGNATURE-----

--Signature=_Fri__31_Oct_2008_18_49_19_+1100_wUqHAs0bZPXBfziz--
