Return-Path: <nico-linux-ppc@schottelius.org>
Received: from scice.schottelius.org (ns.schottelius.org [213.146.113.242])
	by ozlabs.org (Postfix) with SMTP id E93C52BF0C
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Dec 2004 21:39:08 +1100 (EST)
Date: Thu, 16 Dec 2004 11:33:25 +0100
From: Nico Schottelius <nico-linux-ppc@schottelius.org>
To: linuxppc-dev@ozlabs.org
Message-ID: <20041216103325.GA6713@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Subject: Error compiling 40x ppc kernels (walnut)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Good morning!

I am trying to build a 40x / Walnut Linux (only for testing), but
the compile process always breaks:

1. walnut build with ibm emac network card enabled
2. walnut build without ibm emac network card enabled

I am currently using

make ARCH=3Dppc CROSS_COMPILE=3Dpowerpc-linux-uclibc-

on my x86 machine as my ibook is currently at home.

Do you know why those errors occur and can you help me fix them?

The config and the two error messages can be found at
http://schotteli.us/~nico/ppc/walnut/.

Nico

P.S.:=20
I'll try to work through the Oak problem the next weeks, if I have
some free time (Gerhard Jaeger sent me some tips howto fix it).

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQIVAwUBQcFkc7OTBMvCUbrlAQKSfxAAjk11VELYzF5Ed3JDaOYw/W4s1H462Eew
fUYNNQL1tDXL7RPPgk3LLOdrxVtj8C4UTcDCNkI6TfmzIXXYXRI3BmOv/ReeEm1V
QsYjJ3fZ0xPtYic6kEXdktnuHvuelXgrrTryj40d5RcxxGc4cCeikO9X1XiCLo4y
KBSw/GviwsM4csarINEz81oPEmRWjsiO1ZGpL/rkbu2XgUSIVguOXPWy92nUqAV3
fx1j3fpp9uMY28dPNOAiy1d503/t5lRXHjwWExvMb2jrDF43BvgXd+0Ji6zKAJAI
7+JyTHKHDDH6R5Vahe9jPHKgU+vWtymIfQRDICmIMKSOn2eXhB/2IlfWcQ9NPS62
JDE+boFiV81ZHTbvPfo2mDK3Zqkbm9crtPorRM608RIiviHKabnnDrn1feaSzUTl
EG4rE136HG8P8niNYJtXXZcVSMYLDf7f5eVSlMC3QmtzK5XhV5O9/7J39N0+4pIn
jehGOr+lHnaTjCGwkYXEodcIB7/ZxGJRag/c4lIGIiegJiNq0IUqQ8DoyUfDu0WQ
s/ympG26RPwRbS48/feLRCbs2POLLwPLQ9KdQE+SoqNuFgHdOTcyViIrNwhNlSE5
HZzooQTXFluXf5eFOs/Wf4acx1gSYm4FE8dgTH0QjCkc/t3Q6F8onliYVKeI3uUe
k8nGPlPtngY=
=iZND
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
