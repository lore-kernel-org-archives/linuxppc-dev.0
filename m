Return-Path: <joerg@dorchain.net>
Received: from Redstar.dorchain.net (153-133-088-212.ip-addr.teresto.net
	[212.88.133.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.dorchain.net", Issuer "Dorchain Family" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 622A068571
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2005 22:51:33 +1000 (EST)
Received: (from joerg@localhost)
	by Redstar.dorchain.net (8.13.4/8.13.4) id j9ECcNws009598
	for linuxppc-dev@ozlabs.org; Fri, 14 Oct 2005 14:38:23 +0200
Date: Fri, 14 Oct 2005 14:38:23 +0200
From: Joerg Dorchain <joerg@dorchain.net>
To: linuxppc-dev@ozlabs.org
Message-ID: <20051014123823.GA9477@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Subject: 2.6.13 ati (ibook) frambuffer problem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

after upgrading to a vanilla 2.6.13 kernel (from 2.6.12) there seems to
be a problem with the framebuffer driver I use for my ibook. The display
statz at the opnpic message, and after a while the machine reboot (looks
like panic().

Can someone confirm? Or better, point me to a patch ;-)?

For given reason, what is the common method to debug crashes before the
display is working?

TIA,

Joerg

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDT6a/jY4+4PdzvOARApjUAJ9SSurtN09wIUIeg/Bt8sbqBMa/7wCcCdny
pRWe0eZsjIcQ1+wmS3njgDU=
=sKFd
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
