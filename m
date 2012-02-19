Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 7DAC1B6FA8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2012 07:23:58 +1100 (EST)
Date: Mon, 20 Feb 2012 07:23:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Timur Tabi <timur@freescale.com>
Subject: warnings from drivers/tty/ehv_bytechan.c
Message-Id: <20120220072352.4c8131bbcea69afc007a4297@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__20_Feb_2012_07_23_52_+1100_uT4bjJcMAi8XU0/T"
Cc: gregkh@linuxfoundation.org, ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__20_Feb_2012_07_23_52_+1100_uT4bjJcMAi8XU0/T
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Resent with Greg's correct new address]

Hi Timur,

If you build drivers/tty/ehv_bytechan.c as a module, it produces these warm=
ings:

drivers/tty/ehv_bytechan.c:362:1: warning: data definition has no type or s=
torage class
drivers/tty/ehv_bytechan.c:362:1: warning: type defaults to 'int' in declar=
ation of 'console_initcall'
drivers/tty/ehv_bytechan.c:362:1: warning: parameter names (without types) =
in function declaration
drivers/tty/ehv_bytechan.c:334:19: warning: 'ehv_bc_console_init' defined b=
ut not used

console_initcall() is not defined for modules.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Mon__20_Feb_2012_07_23_52_+1100_uT4bjJcMAi8XU0/T
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJPQVpYAAoJEECxmPOUX5FErfEP+wTK1ntoY3Fctp8lm5p2oHM+
n82AF9VgTXxhubZ4HvKvV8b1/EPlcNxqxtiFPMSZBM9a2bcermPX1IG2x+qyQbq9
BCGsXiHAZ9JRsPHWDkGWy97psEHvRISlfozRuH2D5qS9hNrnYRLPWI/sLWJHINc/
3aqitcW2QwPNOKXo1tK9Vx7uK/OldtZnViGePSNwC4CBxSZ6DnHm5RgEGnIFu7YF
2gGdJbTiIfQnLNAHsIkKpg7XahcQzsmLjSQdenMECAWnyk3y8HX5CV6FXzeh52SZ
ulocVWB73tEy1h5dYIcI7kWiWvyYXrR2IGKewYkmiDzHIT/ayuix8gK3SO5cPZ35
dSm1gCzVEZGi6Y5qcHKEK24eXLIUl5jSQSb4Tt3vnRRI9kDBN2P6jVu6nOwOUfYz
gvlOUpx0h4//zY7N9EpUpIPmXinLce60LazGbZX4pYK3/hFlQdqYrdtb2I1x5zfM
DaskBjq5rwWDTTuGkrMhejvczf88noJ2HlteHvMAXhwgPmb/vr22qaxMQ5dELJEa
XFZ4BKvTXBjOe9t7yZHeGMJrGu0nv30uFUYxqfPSyavkFmXC6GpkLK6H9LUf5C4b
JP2yBe4zjQL74zqVasew/BzS+WPcrVNBv3Fh/x2uvHcBdv2gJjQJqQxtdQjM0Ctx
W3DGHBnmEoj1whYwWi38
=C/hI
-----END PGP SIGNATURE-----

--Signature=_Mon__20_Feb_2012_07_23_52_+1100_uT4bjJcMAi8XU0/T--
