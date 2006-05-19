Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B90867A2E
	for <linuxppc-dev@ozlabs.org>; Sat, 20 May 2006 00:37:55 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Johannes Berg <johannes@sipsolutions.net>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jemzdenkyg.fsf@sykes.suse.de>
References: <1147860564.14395.6.camel@johannes>
	<60381eeb0605180025v2495715scb345d7067518ecc@mail.gmail.com>
	<1147947784.15507.46.camel@johannes>
	<87wtcirw0y.fsf@briny.internal.ondioline.org>
	<jemzdenkyg.fsf@sykes.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-8nzF/xCtRLJSq6PV+HI6"
Date: Fri, 19 May 2006 16:37:50 +0200
Message-Id: <1148049470.6228.8.camel@johannes.berg>
Mime-Version: 1.0
Cc: list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>,
	Eddy =?iso-8859-2?Q?Petri=BAor?= <eddy.petrisor@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-8nzF/xCtRLJSq6PV+HI6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-05-19 at 16:33 +0200, Andreas Schwab wrote:
> > [briny(device-tree)] od -c pci@f2000000/mac-io@17/i2s@10000/i2s-a@10000=
/sound/layout-id
> > 0000000  \0  \0  \0   3
> > 0000004
>=20
> Apparently the layout-id on your system is 51 (decimal).

Eh, right, replace 70 by 51 of course. Thanks Andreas.

johannes

--=-8nzF/xCtRLJSq6PV+HI6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARG3YPKVg1VMiehFYAQLLRhAAwBz/JNQlzhK4UZHIq/665/T2eLDgtu3C
A2/K6Yv7FExw6M/I2W88HdcOVbVx8BSO1nwgC9UCjykLI612KQxxgPQRG7mv9ZCF
JHF+t1QCImIlxLU9fKVEiq0kQ/6lv2tKh8S8p1qrTPpJVVCdmHkcIMTYpbSjA+CB
TD9gGCJ6e+0XtpDX6gyL0Nx/E2tw7JlK1IWoPy8rkPtAMxkqB3OeIcikUbMHZzPr
vLmYQzpE/GZvlROSAcVp530mTc4m+C+XEapZW8L9XxaN8s9hQd1kC/jX0rYgR7PD
IKRxqqnTnsIQGtelMakqLTtdkPwgehf9oIf27BCHlEtBcQkTrN5fSmquiyqGsCLq
dAmxukuD/nOZAAq2xAa2P/xHGJVfgwTo9P504rcgxCthtKMl5GlmND9d8Oa+iX6M
1EVw2H1scCUSTqFlQlsRASqPjDkr+XCnxduB4bqehsHt/uABQmRxFSd2HAdqfRdC
dLUmxHlO/85AD+6Umz7jEH7b+4iTwDdGwHulrjECYz7N8WW4r9RgGyZhcBped2fu
vndxjtt/xovFb5LkyIYuSKnWElZGhy89tUVLUUkT7TbgUnUUHb3io3KvHE1ZLgqr
Zmcs24A41BxFiVuMx1isuDTwR2P8uwTJcIPUMb6C98ytirmtWytvI7TTAamw4fPl
/MWzO4RAzQo=
=gbVv
-----END PGP SIGNATURE-----

--=-8nzF/xCtRLJSq6PV+HI6--
