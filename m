Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by bilbo.ozlabs.org (Postfix) with ESMTP id A587AB7154
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Jun 2009 18:34:21 +1000 (EST)
Date: Mon, 22 Jun 2009 18:34:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fbdev: work around old compiler bug
Message-Id: <20090622183415.46fa786b.sfr@canb.auug.org.au>
In-Reply-To: <20090622180420.2e0424e4.sfr@canb.auug.org.au>
References: <20090622180420.2e0424e4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__22_Jun_2009_18_34_15_+1000_ppHojJRl/ruUqHwd"
Cc: James Simmons <jsimmons@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Krzysztof Helt <krzysztof.h1@poczta.fm>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__22_Jun_2009_18_34_15_+1000_ppHojJRl/ruUqHwd
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jun 2009 18:04:20 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> When building with a 4.1.x compiler on powerpc64 (at least) we get
> this error:

Ignore this, it causes more problems:

drivers/video/logo/logo_linux_clut224.c:548: error: logo_linux_clut224_clut=
 causes a section type conflict

I'll work on a better solution.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__22_Jun_2009_18_34_15_+1000_ppHojJRl/ruUqHwd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAko/QgcACgkQjjKRsyhoI8wFwgCfadJlSGyDOj4rWg+P/b+klxoA
S5YAoKjh7PPFs1fh/uTueDGZU+Eb57Ir
=rbt5
-----END PGP SIGNATURE-----

--Signature=_Mon__22_Jun_2009_18_34_15_+1000_ppHojJRl/ruUqHwd--
