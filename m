Return-Path: <nico-linux-ppc@schottelius.org>
Received: from scice.schottelius.org (ns.schottelius.org [213.146.113.242])
	by ozlabs.org (Postfix) with SMTP id D7D812BF10
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Dec 2004 00:39:53 +1100 (EST)
Date: Thu, 16 Dec 2004 14:40:49 +0100
From: Nico Schottelius <nico-linux-ppc@schottelius.org>
To: linuxppc-dev@ozlabs.org
Message-ID: <20041216134049.GD6713@schottelius.org>
References: <20041216103325.GA6713@schottelius.org>
	<200412161318.37998.g.jaeger@sysgo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
In-Reply-To: <200412161318.37998.g.jaeger@sysgo.com>
Subject: Re: Error compiling 40x ppc kernels (walnut)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Gerhard Jaeger [Thu, Dec 16, 2004 at 01:18:37PM +0100]:
> from what I see from your config file, you have enabled a lot of stuff,
> I'm pretty sure which won't build correctly for the walnut.
> I.e. the whole framebuffer stuff is not needed - switch it off.

You got 100 points! After disabling mostly everything, it compiled.

Although I'll need to enable trident framebuffer later, as the thinclient s=
hould be
useable by end-users.

For now I'll concentrate on debugging the oak version.

Have a nice day,

Nico


--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQIVAwUBQcGQX7OTBMvCUbrlAQKmew//QfTTsl1YLq4hMUjTqu+BTdPWWQUqogpP
7wi8usQBebYFILLUcqwFdu8o6j/b8fDO+c6Z4kqwdIQtzJecN3bk0vfuW5RyLbkG
Q43rYcNOs6uSAnTWAGSZ2p2oFHfXqCykvD6i3HyeabKujiSxzepaYYYFeSEojYcj
egZy5v+NZBxKQcO/lllR6kFJO+tfI1DTp+3TCcgbSJDJkcSj20LlZjMKKZ3TRjXa
lXp9LYheC+wdIeGZeRFApjbmtU4ENbPqYlhyC8iNDMozIx3Hebjbjfi2zCcBOUAT
aaPNag6dULKZc/nWvlYIwnogf1HgBgDRswg1DJi9QpagR0Sw6jdEU2K9/xrn6Z9B
8eIvJ0zw+UVHnUy8nVJGxJZq+d/GgSBk+sCdmvButLU7ZKtvtn9NKxSYo52GWE4Q
H33qASTpa1LRVx7b3x9t6B2zMvX1zfghsuT4SOkZO8WvPO63C3zXEtDCatpOZn5m
uyAu5bh6IK9vFq8IeWRHwJZZBToA0CiDuBbqwOHF0nFe6lMTjNAUlkb1gD1iGFPj
XecuRHZi0gUAMA6oXyrd6vrUzNoxvDXmXhJeyGe+NqSxEhEF0Pw6CLBllzPlEPmE
LWx89ai7VwbE0L7hoBtzLq3ef317m8GKkY3PFc6b/r/WCOunvlfCNbxeWtEPt2+S
GKOusuy/MW8=
=49D/
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
