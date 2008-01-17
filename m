Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8E394DDE2F
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 17:36:53 +1100 (EST)
Date: Thu, 17 Jan 2008 17:36:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/2] Make setjmp/longjmp code generic
Message-Id: <20080117173643.ae1756be.sfr@canb.auug.org.au>
In-Reply-To: <15983.1200548209@neuling.org>
References: <1200545142.37022.89292279731.qpush@coopers>
	<20080117044542.2F6CD70006@localhost.localdomain>
	<20080117053857.GA29035@lixom.net> <15983.1200548209@neuling.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__17_Jan_2008_17_36_43_+1100_g8J0pFN=4YvKZjd7"
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com,
	Paul Mackerras <paulus@samba.org>, THEMANN@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__17_Jan_2008_17_36_43_+1100_g8J0pFN=4YvKZjd7
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Jan 2008 16:36:49 +1100 Michael Neuling <mikey@neuling.org> wrot=
e:
>
> >=20
> > Should the above be inside #ifdef __KERNEL__?
>=20
> Yep... _and_ it's 2008 now!

I think that if you don't list the file for exporting to user mode (in
the Kbuild file), then you shouldn't need the __KERNEL__ protectors.

But it is, indeed, 2008. :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__17_Jan_2008_17_36_43_+1100_g8J0pFN=4YvKZjd7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHjveDTgG2atn1QN8RAsYSAJ9hHZY2HGvHPlrRPe4y50SRdDbFxACeLYHW
ObbHjm2RVlQi6zYA5+6ShD4=
=qVVG
-----END PGP SIGNATURE-----

--Signature=_Thu__17_Jan_2008_17_36_43_+1100_g8J0pFN=4YvKZjd7--
