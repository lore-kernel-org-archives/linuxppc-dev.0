Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0410BDDEE1
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Apr 2008 23:14:33 +1000 (EST)
Subject: Re: [PATCH v2] powerpc: Add irqtrace support for 32-bit powerpc
From: Johannes Berg <johannes@sipsolutions.net>
To: benh@kernel.crashing.org
In-Reply-To: <1207543791.10388.468.camel@pasglop>
References: <20080404213932.GA15847@farnsworth.org>
	<1207543791.10388.468.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-5aOBNs3H8qLx6M2/wORa"
Date: Mon, 07 Apr 2008 15:10:09 +0200
Message-Id: <1207573809.12481.6.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-5aOBNs3H8qLx6M2/wORa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Note that I've been wondering wether we should attempt to trace all
> those IRQ state change internally to the exception code. I've looked at
> not doing it, which simplifies things a bit.
>=20
> Unfortunately, that will make us occasionally trace redundant
> enable/disable (which isn't a big problem per-se, just counters).

We already have a huge number of redundant enable/disable, about 40% of
all events on both 32 and 64-bit.

johannes

--=-5aOBNs3H8qLx6M2/wORa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR/odMKVg1VMiehFYAQJNhBAAu0UtzSVg0fidQcQ+wrE1YUlZ03YKMlkB
LoqRBxUKF9OMSjnYvr/uxrCQx22nUVPGRv9h7XItpJK/QbRCbObUbRMf48NKpo+e
SjcK78CQiHvFJIDnEAWPhyRbE6Q6lXES1qH4sjOHVM13D4fbRvncn1OIumr/8odD
mfkUhqd3iw68JBxAcJ06XEqoT8BJWv6Db5Gi/qBqZvmWi/FkKhkUQLq2LY+6GKB+
MWlyOzlGOseLrXxAj6E9SgrDsipdZZSJnJxDxuaMiE9GbPVkK93Gsu5k+0AXVLDD
KdUIczhCZ7P0/W3+Mlme20TEn3PN6I+Vpi+WmMH1e5FHlmre7GXrChzaE7o/M3W5
edp3dr2yyajaw8I+IMwo9FiCiLnT5DeQ3yEgKIzinDAW3icSN1dh96Afvp1yRYlF
0xYWf61AKjc9mk22WulOngzAajMOJpM445q+JNTlR0F0VTTi079evqpskfGFrU4r
tMdTyKMUyNQadeEdglsKsy0uw5/Etj1ssV98+WAzZCyLwY+BC44IDBENVrB0JFVL
zCdDklwEyvceU87D/tNaOENwpKu4mDDyErC7yIuEyE/6n4LFBtFHqLxzaWlNCyIE
ezPDT8VflavSMaI36OtA12Z1D5sNTNo3+hGZ8gXuZzxVcfT0GkDCiKSkmxUkOOlI
X1GuljLVKHQ=
=Fyw+
-----END PGP SIGNATURE-----

--=-5aOBNs3H8qLx6M2/wORa--
