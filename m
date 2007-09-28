Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D4B1DDDE10
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 15:13:43 +1000 (EST)
Date: Fri, 28 Sep 2007 15:13:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: libfdt_env.h must be included first
Message-Id: <20070928151322.a9dee5d9.sfr@canb.auug.org.au>
In-Reply-To: <20070928045206.GA25743@localhost.localdomain>
References: <20070928045206.GA25743@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__28_Sep_2007_15_13_22_+1000_YDPUKH3FFCba25IX"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__28_Sep_2007_15_13_22_+1000_YDPUKH3FFCba25IX
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Sep 2007 14:52:06 +1000 David Gibson <david@gibson.dropbear.id.a=
u> wrote:
>
> libfdt.h currently includes fdt.h, then libfdt_env.h.  This is
> incorrect, because depending on the environment into which libfdt is
> embedded, libfdt_env.h may be needed to define datatypes used in
> fdt.h.  This patch corrects the problem.

So why doesn't fdt.h include libfdt_env.h, then?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__28_Sep_2007_15_13_22_+1000_YDPUKH3FFCba25IX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG/I13TgG2atn1QN8RAvHbAJ4yfEJuGAIv45pWMWLQoTLNntjZxgCfddTz
H/AUYGTq16D7uX41vNyxeCY=
=3BaG
-----END PGP SIGNATURE-----

--Signature=_Fri__28_Sep_2007_15_13_22_+1000_YDPUKH3FFCba25IX--
