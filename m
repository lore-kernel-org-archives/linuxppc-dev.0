Return-Path: <joerg@dorchain.net>
Received: from Redstar.dorchain.net (153-133-088-212.ip-addr.teresto.net
	[212.88.133.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 91A7B67A2C
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2005 20:31:51 +1100 (EST)
Received: (from joerg@localhost)
	by Redstar.dorchain.net (8.13.2/8.13.2) id j0I9JqGl026239
	for linuxppc-dev@ozlabs.org; Tue, 18 Jan 2005 10:19:52 +0100
Date: Tue, 18 Jan 2005 10:19:52 +0100
From: Joerg Dorchain <joerg@dorchain.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Message-ID: <20050118091952.GA25470@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Subject: First time kernel impression
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I recently got a new iBook G4 and installed (Debian-)Linux on it. To  be
special, I did not touch the pre-installed Mac OS X on the internal HD,
but used an external firewire drive for linux.

After struggeling with some quirks (Debian Installer has two problems
with this setup that prevent it making the system bootable without
help), I wanted my own kernel and took Linus' 2.6.10 tree.

The kernel runs well, although IMHO the configuration has some quirks
worth commenting on.

As I do not use the IDE drive for booting, I wanted to compile the whole
ide stuff as a modules. This is obviously not implemented (yet).
Besides, powermac ide support only compiles and links if BLK_DEV_IDE,
BLK_DEV_IDE_PCI, and BLK_DEV_IDEDMA_PCI are selected as compiled in as
well, although this is not expressed in the Kconfig dependencies. (Ok,
the most common case is most likely to boot from the ide hd and
therefore have it all statically compiled in.)

Bye,

Joerg

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB7NS4jY4+4PdzvOARAuEjAJwI0sRUdDWsEglLTWjTfAbIswHF1QCgimiw
4Yf+BQD1pSwke8PE/iMM36g=
=prD7
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
