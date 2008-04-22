Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 9F7DEDE151
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 14:02:27 +1000 (EST)
Date: Tue, 22 Apr 2008 14:02:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH 2/3] Make iSeries spin on __secondary_hold_spinloop,
	like pSeries.
Message-Id: <20080422140222.23adcbb4.sfr@canb.auug.org.au>
In-Reply-To: <7be4c4c6f56d04b595c92690b297de17140304d2.1208834828.git.tony@bakeyournoodle.com>
References: <767e424a294239aba86aa7da086f6395f7066d14.1208834828.git.tony@bakeyournoodle.com>
	<7be4c4c6f56d04b595c92690b297de17140304d2.1208834828.git.tony@bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__22_Apr_2008_14_02_22_+1000_8WKGn//2OanlvJZ0"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__22_Apr_2008_14_02_22_+1000_8WKGn//2OanlvJZ0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Tue, 22 Apr 2008 13:30:06 +1000 (EST) Tony Breeds <tony@bakeyournoodle.c=
om> wrote:
>
> Currently all iSeries secondary CPU's spin directly on the cpu_start in t=
hier
> paca.  Make them spin on the global __secondary_hold_spinloop, until afte=
r the
> pacas have been initialised.
>=20
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

(Noting that the __secondary_hold_spinloop variable was already being set
for legacy iSeries even though it was not being used previously.)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__22_Apr_2008_14_02_22_+1000_8WKGn//2OanlvJZ0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIDWNSTgG2atn1QN8RAmBXAKCCwxbcD54ZqkB3ypro70f1WyyNXgCfRJUu
Bo3FKJYiTmRMeLRVLzpoeZ4=
=e9eY
-----END PGP SIGNATURE-----

--Signature=_Tue__22_Apr_2008_14_02_22_+1000_8WKGn//2OanlvJZ0--
