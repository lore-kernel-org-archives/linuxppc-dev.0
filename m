Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 443F2DE317
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 20:24:38 +1100 (EST)
Date: Mon, 12 Jan 2009 20:24:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-next: origin tree build failure
Message-Id: <20090112202427.3b918490.sfr@canb.auug.org.au>
In-Reply-To: <20090112090552.GD26750@elte.hu>
References: <20090112104837.69feedec.sfr@canb.auug.org.au>
	<1231719015.22571.4.camel@pasglop> <20090112090552.GD26750@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__12_Jan_2009_20_24_27_+1100_/JyRDOi8rZBaYYJ."
Cc: Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>,
	Mike Travis <travis@sgi.com>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__12_Jan_2009_20_24_27_+1100_/JyRDOi8rZBaYYJ.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

On Mon, 12 Jan 2009 10:05:52 +0100 Ingo Molnar <mingo@elte.hu> wrote:
>
> Yeah - and that build bug was stupid too - when touching a generic file=20
> that is called include/linux/cpufreq.h and changing a key data field one=
=20
> should at minimum get the idea that it's generic for a reason and should=
=20
> start grepping the tree ...
>=20
> It slipped through because it didnt get caught in build tests because=20
> cpufreq isnt enabled in the powerpc defconfig.

Which is one of the reasons we have linux-next: "integration testing".
This way not every developer/maintainer has to have/use cross compilers
for every (or even many) non-native (from their point of view)
architectures.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__12_Jan_2009_20_24_27_+1100_/JyRDOi8rZBaYYJ.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklrDEsACgkQjjKRsyhoI8ymBACfbaSepcd6JqVSw4AK/Agw76h2
gMUAn16XM2ZKM6R55hjoGR98y8pX4zcx
=kXHG
-----END PGP SIGNATURE-----

--Signature=_Mon__12_Jan_2009_20_24_27_+1100_/JyRDOi8rZBaYYJ.--
