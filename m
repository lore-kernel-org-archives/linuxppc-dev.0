Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C799CDDDEF
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 01:36:03 +1100 (EST)
Date: Thu, 20 Nov 2008 01:35:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: linux-next: spinlock lockup with next-20081118 on powerpc
Message-Id: <20081120013552.587f8928.sfr@canb.auug.org.au>
In-Reply-To: <20081119133408.GE26308@kernel.dk>
References: <20081119093023.48895b84.sfr@canb.auug.org.au>
	<20081119091628.GT26308@kernel.dk>
	<20081119203922.0412c041.sfr@canb.auug.org.au>
	<20081119094300.GW26308@kernel.dk>
	<20081119213304.d2d21042.sfr@canb.auug.org.au>
	<20081119105833.GZ26308@kernel.dk>
	<20081120003224.8d0f481c.sfr@canb.auug.org.au>
	<20081119133408.GE26308@kernel.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__20_Nov_2008_01_35_52_+1100_6Dxg1y1M91uVj7+5"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__20_Nov_2008_01_35_52_+1100_6Dxg1y1M91uVj7+5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Wed, 19 Nov 2008 14:34:09 +0100 Jens Axboe <jens.axboe@oracle.com> wrote:
>
> Are you removing devices or modules? We have a bug there it seems, does
> this help?

This is early in boot (we are waiting for the root device while running
on the initramfs) so there could well be modules being unloaded.

That patch makes the problem go away.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__20_Nov_2008_01_35_52_+1100_6Dxg1y1M91uVj7+5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkkJEgACgkQjjKRsyhoI8yVZQCfZddD/M02ZsImbbXcmjPM6LOj
KXgAoLrbdQhUX1trmziISZdyr99+IKdo
=8tMT
-----END PGP SIGNATURE-----

--Signature=_Thu__20_Nov_2008_01_35_52_+1100_6Dxg1y1M91uVj7+5--
