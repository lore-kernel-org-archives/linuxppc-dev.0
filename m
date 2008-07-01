Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DD3A8DE067
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 21:00:03 +1000 (EST)
Date: Tue, 1 Jul 2008 20:59:55 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: linux-next: manual merge of the ttydev tree
Message-Id: <20080701205955.a78a979b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__1_Jul_2008_20_59_55_+1000_Tuu6kE2ooAl3lZ8+"
Cc: Adrian Bunk <bunk@kernel.org>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Mackerras <paulus@samba.org>, Paul
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__1_Jul_2008_20_59_55_+1000_Tuu6kE2ooAl3lZ8+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan,

Today's linux-next merge of the ttydev tree got a conflict in
drivers/serial/cpm_uart/cpm_uart_core.c between commit
0b2a2e5b7747f1f63bd86ca22b5c6097da5b2137 ("cpm_uart: Remove
!CONFIG_PPC_CPM_NEW_BINDING code") from the powerpc tree and commit
33e211d606d46d18befa6fe6aec76aa7971eefa8 ("03-serial_vcs") from the
ttydev tree.

The former removes some of the code modified by the latter.  It is a
simple fixup and I can carry it.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__1_Jul_2008_20_59_55_+1000_Tuu6kE2ooAl3lZ8+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhqDisACgkQjjKRsyhoI8wqLACgqvmPHKx0n+W5MyMLgy7papx+
2JoAoLIj1ndkNiiNQW+I2jvIfWw1eT+0
=OlYI
-----END PGP SIGNATURE-----

--Signature=_Tue__1_Jul_2008_20_59_55_+1000_Tuu6kE2ooAl3lZ8+--
