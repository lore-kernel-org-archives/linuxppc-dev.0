Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] drivers/char/hvc_console.c: reduce max idle timeout
From: Michael Ellerman <michael@ellerman.id.au>
To: Chris Metcalf <cmetcalf@tilera.com>
In-Reply-To: <201010271659.o9RGxrMc009847@farm-0002.internal.tilera.com>
References: <201010271659.o9RGxrMc009847@farm-0002.internal.tilera.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-4k4D+9f+1rOX9vb6Ps6h"
Date: Tue, 02 Nov 2010 11:35:08 +1100
Message-ID: <1288658108.16790.13.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-4k4D+9f+1rOX9vb6Ps6h
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-10-27 at 12:54 -0400, Chris Metcalf wrote:
> The tile architecture uses this framework for our serial console,
> and our users complain that the delay of up to two seconds feels like
> the machine has gone non-responsive and is disturbing.  By contrast,
> a delay of up to half a second feels like just the normal sort of
> delay caused by swapping, network lag, etc. and is not noticeable.
> The overhead is obviously not much greater.

It's 4 times greater.

We picked 2 seconds because it gave a reasonable trade off between
responsiveness and load. I'm not convinced that half a second is a
better number.

cheers


--=-4k4D+9f+1rOX9vb6Ps6h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkzPXLwACgkQdSjSd0sB4dIPfwCdEiPhA3IsXqmoqmHBE/xKE7+3
YhwAoJC4YPrHS49jyJVGY4EmgyF5GCyG
=Fa+n
-----END PGP SIGNATURE-----

--=-4k4D+9f+1rOX9vb6Ps6h--
