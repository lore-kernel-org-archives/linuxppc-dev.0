Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 07D4EDDDDB
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 20:57:43 +1100 (EST)
Date: Tue, 22 Jan 2008 20:57:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] 8xx: Analogue & Micro Adder875 board support.
Message-Id: <20080122205735.a9db7507.sfr@canb.auug.org.au>
In-Reply-To: <20080117223140.GA17300@loki.buserror.net>
References: <20080117223140.GA17300@loki.buserror.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__22_Jan_2008_20_57_35_+1100_B/H_f3px8OTkX21g"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__22_Jan_2008_20_57_35_+1100_B/H_f3px8OTkX21g
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Scott,

Just one small thing.

On Thu, 17 Jan 2008 16:31:40 -0600 Scott Wood <scottwood@freescale.com> wro=
te:
>
> +static __initdata struct of_device_id __initdata of_bus_ids[] =3D {

You don't need to mark it __initdata twice ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__22_Jan_2008_20_57_35_+1100_B/H_f3px8OTkX21g
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHlb4VTgG2atn1QN8RAojnAJsHjLhb2Q6Iq8QU0PsPG/zXzEhfTwCdGQ14
Izsl/yJtFJj5UJuWQcfI4Gc=
=hJl7
-----END PGP SIGNATURE-----

--Signature=_Tue__22_Jan_2008_20_57_35_+1100_B/H_f3px8OTkX21g--
