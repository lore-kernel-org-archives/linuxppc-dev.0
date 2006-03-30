Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (unknown [213.151.39.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D9533679E0
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 09:38:27 +1100 (EST)
Subject: Re: [PATCH] PowerMac11,2 i2c-bus@0 duplicate dev-tree workaround
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael Ellerman <michaelellerman@internode.on.net>
In-Reply-To: <1143700119.23392.27.camel@localhost.localdomain>
References: <1143631816.9481.5.camel@localhost>
	<1143700119.23392.27.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-tRCacizKOTt3w3CWyPA5"
Date: Fri, 31 Mar 2006 00:38:17 +0200
Message-Id: <1143758297.5388.12.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-tRCacizKOTt3w3CWyPA5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-03-30 at 17:28 +1100, Michael Ellerman wrote:

> I don't understand why we need this patch? If we care about getting the
> "right" node why not check for that where we care?

It's not just a single node but also contains sub-nodes. In one of them,
one of those sub nodes is there but contains bogus info, and in the
other both are there and contain the right info. Some things that work
off these bus nodes are detected twice if they're there, and they're
used in at least two places that I know of.

johannes

--=-tRCacizKOTt3w3CWyPA5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCxd1qVg1VMiehFYAQIVuQ//TO2Cgum95DIU8Zw5QRW9Kbyjh5/Folgr
XJmfiIUkGo3P/f6DB7FjLFgoS3TiHnwK3X311rAHLFZH9oJpSuM4OH+49Xs3Osl0
SP4Okg4GteAD6Hc8QOY4okJjoYTnD/q1e+Ebm+pUN1TAxYkKGWBWHnhiN7shCTj2
HAEJQYcJX2Q3J5dxvD/XEn4i5U5b8BWuveYbAJ/ESTmyqeNP3ysGoVEkQzperDHb
UQ8G5/b93umSJrrdIAuf1m1vOOeefpQc7HviWineQdxy52hgTsXlw1JG6ox3zBxJ
DAmJ/tnQ+18fom2ETlPuk1EYZOrmkfg5onCoNBjBn9SRD5RvkEU+kf4l3tSbzbYN
gW0jfgIRD7lT3SILxYOIp/lzNab1ugVCo/FMIPL8x1meUxMtSoITMMwaI0dH0KQs
rG1jNjKNDKYOnaQ5Hkb2RP9ug/d8UZpI77qbpDlEwSPB2tigZhKVhy2M+etFw8pU
RAhPIiHdiamTWbVV5LsSBLHymmeaYdJNW11nKYE9TnOPl3+OAyW6xkavP+P4z5nM
Gnq+YgNajQJdE+nd5wce3RRtRxKYTdgwWbpYJEQonxB5Mg9/uPkdq33TAnvRUUVM
SMZuzXwp0jWvFBFFzDTDtNGVjvr8M742O4tLK0/De9tufirZWGE4DyonKEHAoudB
XKhDEF/3eo8=
=CtbB
-----END PGP SIGNATURE-----

--=-tRCacizKOTt3w3CWyPA5--
