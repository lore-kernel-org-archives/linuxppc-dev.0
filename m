Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id D24C0B6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2012 07:07:28 +1100 (EST)
Date: Mon, 20 Feb 2012 07:07:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Timur Tabi <timur@freescale.com>
Subject: warnings from drivers/tty/ehv_bytechan.c
Message-Id: <20120220070721.4357dceb3bde318f694fbfac@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__20_Feb_2012_07_07_21_+1100_ZMhhK5rQ75IWVVIx"
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__20_Feb_2012_07_07_21_+1100_ZMhhK5rQ75IWVVIx
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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

--Signature=_Mon__20_Feb_2012_07_07_21_+1100_ZMhhK5rQ75IWVVIx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJPQVZ5AAoJEECxmPOUX5FEvBEP/R4w8LvDYmHQIs8zO9GyYx9f
mFe3FAaEtH31KSfsUpHr9P+yyBegeCZn5gCZ8vbqfE6mrvNiF+T7nlc67liMffv4
jR/nPfjk1zadbtDBGwYjh62MZo2BQ6puwl5u5RIE7La45KJ+b9iEAnTqhEjYYijN
YIN0GMEeOMdo/WDRmBBwU2f0R9MY76CHeODNK0m3XUbEr8/4EneAkJXg0zowZ0ST
uq9iRjGDKl4eIHBj8Vh38HNzmXFDC2o7inN/hnf07G46mki9I6mLUWDZgb5MyDY5
X8Y078KgxdqzPjZ8BVLkrCMobrPzphxhme5biFkKtFRqS5HhDwiZjMuqtKFCsXW/
p62jE8YL3MRxb/0FbI5iJOGM3KT5JI6weBVWjMtdwCNeEoW03k0ebY3OuqQ9GwPS
Uw6ybHBFbSBXIp0w0TXNEyhG7Yw9kXGqu3JAqiJqfHhECxAoiM+GVYwZSUQLoj93
kZEc0GXLyUSdOzAcf+l2pCJeoUncOhsm4HAGF9lRlLB1qziyYoH1QpstamMjXelY
yEEh5XatQFde8klhoHkAgn9qzfMTZ+dlsCliTmoVOLPyNeVoiZk3MC36li9zVcX4
SS5KUXRI9wcuTP4oskOQF23zp/dlkTInZ5Y0qn60qHYysNzq1ki1jMjOH7QKiWPw
epJ4vhQTNJGUpxOom6Hx
=ks0Q
-----END PGP SIGNATURE-----

--Signature=_Mon__20_Feb_2012_07_07_21_+1100_ZMhhK5rQ75IWVVIx--
