Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4B07BDE09B
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 21:30:11 +1000 (EST)
Subject: Re: [PATCH] powerpc/ftrace: Use pr_devel() in ftrace.c
From: Michael Ellerman <michael@ellerman.id.au>
To: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <alpine.DEB.2.00.0905141149130.30591@gandalf.stny.rr.com>
References: <e805665453162bf2eb90b402e41fc7b672fcf639.1242282612.git.michael@ellerman.id.au>
	<alpine.DEB.2.00.0905141149130.30591@gandalf.stny.rr.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-iWSWsv1GGUexFmzyuHKZ"
Date: Fri, 15 May 2009 21:30:10 +1000
Message-Id: <1242387010.7946.2.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-iWSWsv1GGUexFmzyuHKZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-05-14 at 11:49 -0400, Steven Rostedt wrote:
> I'm fine with this patch, but it should go via the PPC tree.

Yep, it went To linux-ppc, CC you - so that's the plan, I'll nag Ben to
pick it up.

> Acked-by: Steven Rostedt <rostedt@goodmis.org>

Thanks for the ack.

cheers

--=-iWSWsv1GGUexFmzyuHKZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoNUj4ACgkQdSjSd0sB4dJYkwCfapHsOS3Cl1A8cTcq0bOXTZ4f
aWYAoMaOvhXy8F+dbiU2W3OUPgK8j2wX
=2tJo
-----END PGP SIGNATURE-----

--=-iWSWsv1GGUexFmzyuHKZ--
