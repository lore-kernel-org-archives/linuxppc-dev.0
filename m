Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6FBE8DDF0D
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 13:12:06 +1000 (EST)
Date: Wed, 6 Jun 2007 13:11:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 02/18] PS3: Rename IPI symbols
Message-Id: <20070606131157.133ce9bb.sfr@canb.auug.org.au>
In-Reply-To: <4666230D.4020902@am.sony.com>
References: <20070606024407.786638029@am.sony.com>
	<4666230D.4020902@am.sony.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__6_Jun_2007_13_11_57_+1000_2mFqh6EQiMHTcqtF"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__6_Jun_2007_13_11_57_+1000_2mFqh6EQiMHTcqtF
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 05 Jun 2007 19:59:25 -0700 Geoff Levand <geoffrey.levand@am.sony.co=
m> wrote:
>
> Rename the PS3 static symbol virqs to ps3_ipi_virqs to aid in
> debugging.
>=20
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>
>  	for (i =3D 0; i < MSG_COUNT; i++) {
> -		free_irq(virqs[i], (void*)(long)i);
> +		/* Can't call free_irq from interrupt context. */

This change is probably worth a mention in the change log - it looks like
a bug fix.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__6_Jun_2007_13_11_57_+1000_2mFqh6EQiMHTcqtF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGZiYEFdBgD/zoJvwRAkO8AKCdzv9YY/6gyWK9FRcCGPfGwv6jXQCfVSZv
ZU2HrMQPAdRCBP1uJBMIiMI=
=8Aot
-----END PGP SIGNATURE-----

--Signature=_Wed__6_Jun_2007_13_11_57_+1000_2mFqh6EQiMHTcqtF--
