Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1E46EDDEDA
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 14:09:59 +1000 (EST)
Date: Mon, 21 Jul 2008 14:09:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] Don't panic when EEH_MAX_FAILS is exceeded
Message-Id: <20080721140946.ca314d2e.sfr@canb.auug.org.au>
In-Reply-To: <20080720234756.03b602ca@lappy.seanm.ca>
References: <488383D4.9000602@us.ibm.com>
	<20080720145858.5be92934@lappy.seanm.ca>
	<20080720201708.GP9594@localdomain>
	<20080720234756.03b602ca@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__21_Jul_2008_14_09_46_+1000_KwtxG72=WXf7bn_J"
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	Sean MacLennan <sean.maclennan@ottawa.kanatek.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__21_Jul_2008_14_09_46_+1000_KwtxG72=WXf7bn_J
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Sun, 20 Jul 2008 23:47:56 -0400 Sean MacLennan <smaclennan@pikatech.com>=
 wrote:
>
> I guess I am too x86 centric. On the x86 an msleep does not give up the
> CPU. It does a busy wait.

I think you must be thinking of mdelay().

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__21_Jul_2008_14_09_46_+1000_KwtxG72=WXf7bn_J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiEDAoACgkQjjKRsyhoI8xoFACgrT2SGrk4U/gvMTTJGUrKYhv7
cwYAnjCPWUPdHK68eGXP5n7nuq+wd4Qq
=QSlW
-----END PGP SIGNATURE-----

--Signature=_Mon__21_Jul_2008_14_09_46_+1000_KwtxG72=WXf7bn_J--
