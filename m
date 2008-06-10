Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5AD76DDF02
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 10:21:34 +1000 (EST)
Date: Tue, 10 Jun 2008 10:21:25 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] drivers/macintosh/: possible cleanups
Message-Id: <20080610102125.2816c9e3.sfr@canb.auug.org.au>
In-Reply-To: <20080609222312.GM1987@cs181133002.pp.htv.fi>
References: <20080609222312.GM1987@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__10_Jun_2008_10_21_25_+1000_GP8DqNLn=BRPWlgB"
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__10_Jun_2008_10_21_25_+1000_GP8DqNLn=BRPWlgB
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Tue, 10 Jun 2008 01:23:12 +0300 Adrian Bunk <bunk@kernel.org> wrote:
>
> +++ b/drivers/macintosh/adbhid.c
> @@ -75,7 +75,7 @@ static struct notifier_block adbhid_adb_notifier =3D {
>  #define ADB_KEY_POWER_OLD	0x7e
>  #define ADB_KEY_POWER		0x7f
> =20
> -u16 adb_to_linux_keycodes[128] =3D {
> +static u16 adb_to_linux_keycodes[128] =3D {

This could be const as well.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__10_Jun_2008_10_21_25_+1000_GP8DqNLn=BRPWlgB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhNyQUACgkQTgG2atn1QN+jaQCgjKxLkVMCwhto8f8U1rI2yONg
C/sAnjB/q7BfS+jvF2cWpRQJWeVfrZ8T
=oEwN
-----END PGP SIGNATURE-----

--Signature=_Tue__10_Jun_2008_10_21_25_+1000_GP8DqNLn=BRPWlgB--
