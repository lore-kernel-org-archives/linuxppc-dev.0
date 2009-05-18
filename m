Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5440DDE050
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 11:24:34 +1000 (EST)
Subject: Re: [PATCH] powerpc: Make the NR_CPUS max 8192
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <17087.1242609196@neuling.org>
References: <17087.1242609196@neuling.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-JxJIjAKiK46r42zU707W"
Date: Mon, 18 May 2009 11:24:33 +1000
Message-Id: <1242609873.13757.4.camel@concordia>
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-JxJIjAKiK46r42zU707W
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-05-18 at 11:13 +1000, Michael Neuling wrote:
> We can compile and boot with NR_CPUS=3D8192, so make this the max.  1024
> was an arbitrary decision anyway.

Is 8192 still arbitrary? Or does something break above that?

cheers

--=-JxJIjAKiK46r42zU707W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoQuM0ACgkQdSjSd0sB4dKgSwCfbKo7HVrt5T11sVfjLi8RHgPH
AnsAn2lCB6JciYeIzgmDUJNU1bes8zsd
=khXI
-----END PGP SIGNATURE-----

--=-JxJIjAKiK46r42zU707W--
