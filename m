Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C64B7DE059
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 21:43:18 +1100 (EST)
Subject: powerbook VT garbled between rc7 and rc8
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-HI48QWSGASSsOglg1wz0"
Date: Fri, 12 Dec 2008 11:42:34 +0100
Message-Id: <1229078554.3600.8.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-HI48QWSGASSsOglg1wz0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

After upgrading to -rc8 yesterday my powerbook started up today with the
screen totally garbled, only occasionally was a word readable. I also
tried adding radeonfb=3Daccel_cexp to the command line but that changed
nothing. Also, once I was in X, it seemingly worked fine, but then I
opened up a terminal and tried setting the boot volume to 0 (nvsetvol 0)
[I had booted OSX yesterday] and the machine simply shut down and reset
its clock.

Something's amiss, but I have no idea what yet, and don't have time to
further diagnose/bisect before the end of next week.

johannes

--=-HI48QWSGASSsOglg1wz0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJQkAVAAoJEKVg1VMiehFYV4MP/2spMUOl1c0YoCQpQE9qIsd1
MpfIgLp1L1MLyz9eN4J85yBIbMJqC2Mp5G01hMvGaJtD9yIZKMF2MI4cTvQE9Q6R
FRR7oDgpHa/nusRWElvfvHRI/2fwYq/8kDsQb+1u3gzicGNPTK3im6q7CgISUmCc
Pg3khUeTm64sxBAZ3F/xzVkkJecGWC29Hn4g33LtviC2brka9Bl2UQX2qoSO7SCx
AfavEhsHss8sB1dBr9tayWkTFpvsHcg3moPqUBNLWiyxq6dnwRSMwdeClaYaPBlW
qdxseOQ5uFJFEcg67Skz1IzyyKi7ptl3HTaVkZUw+AjTBqSyvlA8DKbDw71Zj4nV
D4U5QYeQuXvg5UYtirWzVTuAHrAdwh7oZK56qJEHONjfOa6va73IoVuEZPxjz+L2
Ds9gv4/WWRAJhdz1HeVyy6oA82sNMr800zUO1pZ1e8cyCF6TOjUAxr6lRyctm3fT
vYtgxfgNeF6jZFw9lP/b3ZQbSNKJfbRDuQXSXHvbNQKYzzukdTtE8Coma0cyOsyp
ab5gG+WxO8JqgJlaqJV+eeRYPWoFiEp/ZJsD2WxmWlGGBpA3CTEwCiLtoDXJ50S5
eircKGKKg6OGUsvJ25mlHqV2sggFZ+Sgn/5rp8XQUKFmSWFpCWKBIZ7gToIEu+LS
hN3JHTASLtG8ViRrzF5i
=PuJ3
-----END PGP SIGNATURE-----

--=-HI48QWSGASSsOglg1wz0--
