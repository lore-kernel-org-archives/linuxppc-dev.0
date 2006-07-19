Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2286567B81
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 04:38:44 +1000 (EST)
Subject: Re: AltiVec in the kernel
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17598.30626.663773.229019@cargo.ozlabs.ibm.com>
References: <E40C6B7A-F2E8-4DB8-97D3-2CFF88C1D90A@kernel.crashing.org>
	<005701c6aa7c$632a48e0$99dfdfdf@bakuhatsu.net>
	<17597.8378.972640.464219@cargo.ozlabs.ibm.com>
	<20060719181047.GL5905@austin.ibm.com>
	<17598.30626.663773.229019@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-m0UVPlVr66aa7ZQBsGHP"
Date: Wed, 19 Jul 2006 20:38:21 +0200
Message-Id: <1153334301.2546.40.camel@johannes.berg>
Mime-Version: 1.0
Cc: 'linuxppc-dev list' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-m0UVPlVr66aa7ZQBsGHP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-07-20 at 04:19 +1000, Paul Mackerras wrote:
> Linas Vepstas writes:
>=20
> > But perhaps, in principle, couldn't one run four independent streams=20
> > in parallel?  Thus, for example, on an SSL-enabled web server, one=20
> > could service multiple encryption/decryption threads at once.=20
>=20
> Generally that would work.  If one had 4 separate streams to compute a
> SHA1 of, one could do all 4 at once with altivec.  It would have to be
> 4 separate streams though, not 4 parts of a single stream.

I'd think it'd be pretty hard to get a real benefit from this because
the data is going to come from 4 totally different places, hence you
can't just load a single vector register and get data for all 4
streams...

johannes

--=-m0UVPlVr66aa7ZQBsGHP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARL58HKVg1VMiehFYAQKJig//cXLamm4OAWKkZRXs3uHLyy8dVNvlknFF
Ad+zTK8XpSHyt0whyWTN7UUpaTTKMLwUpiNg/F3ODtzWKNtG9hDlT8tvOmhmgWUn
XkqZ8+qfyIgndM5kUFhsOK89u8ifgr520CBBa2BQ/Yw9RYS2bq898g/9LnQ/ukDN
iw8kARubQdEa5Mbwg4BEfEYOQFVJegzAQw/gbf2q/LY25vjGIyDOGlX/PWHBx6Sg
eaXIs1479Mis3XRcPcrManLwC+sPb5IrzWLclVVwf+lsu2ObMQ+MExKTrfPRMIq3
U0jlDdo6G6Qgw8nCXliKsN5WSLUSigD00MOsAXS7r2Uh7yGAzqcVIf8OD0UYA8Eb
28NKdyPdPf2JUu95tcOujwAbphIL1hUiSHuW8z0WOgMba9EN9XyD4lYUH9iUnBkH
dDr0IzcUm1VvJ0gBoATH2ET1GFONMJcUNnaSQv0rTsXewKBTNw+OdG1e073mKS3x
/6EOFd3m1ALEACtGDK99E2u2V13RCzueL7OenL4KhbM7xGDQYWOt0UFElQeO/HPw
s/QONUKmLban7KRy+R7vcGPgLu4CAEkJ3GcwYEAmYnjgo90OxeBQBRCqomnmchWr
gT/McoV/B5/rUq+KJs3qa9HsxhdvE25d29SDXvJSRqWpd5HVJ33MS9ru1gJKEp5P
b2LvICqNNVI=
=QSQA
-----END PGP SIGNATURE-----

--=-m0UVPlVr66aa7ZQBsGHP--
