Return-Path: <joerg@dorchain.net>
Received: from Redstar.dorchain.net (153-133-088-212.ip-addr.teresto.net
	[212.88.133.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1AFA767A61
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2005 21:14:54 +1100 (EST)
Received: (from joerg@localhost)
	by Redstar.dorchain.net (8.13.2/8.13.2) id j0JAEmMa001712
	for linuxppc-dev@ozlabs.org; Wed, 19 Jan 2005 11:14:48 +0100
Date: Wed, 19 Jan 2005 11:14:48 +0100
From: Joerg Dorchain <joerg@dorchain.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Message-ID: <20050119101448.GA1374@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Subject: nvram driver not possible as a module
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

KConfig says CONFIG_NVRAM is possible as a module. Loading the module
fails because of an unknown symbol __alloc_bootmem. __alloc_bootmem is
marked __init. The obvious workaround is to compile the driver not as a
module, but how can this get really fixed?

Bye,

Joerg

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB7jMYjY4+4PdzvOARAnCHAKCFQ6vnjvzP86ypEfIAtZzWqLKjtgCgj1sD
isoih5INQaMb2KDi6jYeqdM=
=UOdN
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
