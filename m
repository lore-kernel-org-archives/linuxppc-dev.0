Return-Path: <jason.mcmullan@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.203])
	by ozlabs.org (Postfix) with ESMTP id 8519B67B35
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 00:30:54 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id 13so39278nzp
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Jun 2005 07:30:52 -0700 (PDT)
From: Jason McMullan <jason.mcmullan@gmail.com>
To: Allen Curtis <acurtis@onz.com>
In-Reply-To: <c2628642aad8b8107d0e9db84535ea0c@onz.com>
References: <42eb0bacadb197b42502ac1828450843@onz.com>
	<a38c1fefe53947c6b80ec3d6b4ffd09e@freescale.com>
	<c2628642aad8b8107d0e9db84535ea0c@onz.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-vfltKPApOsT74DkyfZT1"
Date: Wed, 15 Jun 2005 10:24:10 -0400
Message-Id: <1118845450.7564.111.camel@jmcmullan.timesys>
Mime-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: cpm2_devices.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-vfltKPApOsT74DkyfZT1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

My personal opinions:

	* Use macro-offsets into a cpm2_map_t struct
	* Put fcc_c regs back in
	* dpram[PROFF_*] should be in the resources list
	* cpm2_* is a better name than MPC82xx_* or MPC85xx_*
	* Keep CPM2_DMA, etc, as these *should* be showing up in
	  /proc/iomem, since, IIRC, the platform layer does
	  reserve them upon registration. (And I *do* have a DMA
	  layer then uses CPM2_DMA as a driver-ish thing)

--=20
Jason McMullan <jason.mcmullan@gmail.com>
"Sure, send me the latest Knoppix DVD as an attachment..."

--=-vfltKPApOsT74DkyfZT1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCsDoK8/0vJ5szK6kRAs97AJ9YR9QGe61AkoIaHv2eyMtp1l3mMQCgrOap
zsixkuWy+WbtJ1aOTqqs8G4=
=QwbE
-----END PGP SIGNATURE-----

--=-vfltKPApOsT74DkyfZT1--
