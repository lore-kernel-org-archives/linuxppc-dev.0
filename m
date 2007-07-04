Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BD7D8DDEE9
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 14:15:39 +1000 (EST)
Date: Wed, 4 Jul 2007 14:15:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 2.6.23] 83xx USB platform code rework
Message-Id: <20070704141514.cc77369f.sfr@canb.auug.org.au>
In-Reply-To: <11834557963629-git-send-email-leoli@freescale.com>
References: <11834557963629-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__4_Jul_2007_14_15_14_+1000_vCBPvHQ4DnJXSEvv"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__4_Jul_2007_14_15_14_+1000_vCBPvHQ4DnJXSEvv
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Li,

On Tue,  3 Jul 2007 17:43:16 +0800 Li Yang <leoli@freescale.com> wrote:
>
> Add 831x USB platform setup code and rework 834x USB
> platform setup code.  Move USB platform code to usb.c
> for different boards with CPU of the same series to share
> the USB initialization code.

If there really is a part of this that is just code movement, then that
should be split out into a separate patch.  It makes the reviewers job so
much easier.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__4_Jul_2007_14_15_14_+1000_vCBPvHQ4DnJXSEvv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGix7cTgG2atn1QN8RAsWTAJ0ZsPUqD5F7L5FyRazO9xR7bE8nCgCffgNf
kzWLvGEy6AJ0kzACwSHWfuk=
=04bu
-----END PGP SIGNATURE-----

--Signature=_Wed__4_Jul_2007_14_15_14_+1000_vCBPvHQ4DnJXSEvv--
