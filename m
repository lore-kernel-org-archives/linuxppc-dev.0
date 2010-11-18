Return-Path: <dgibson@ozlabs.org>
Date: Thu, 18 Nov 2010 23:54:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: application needs fast access to physical memory
Message-ID: <20101118125425.GE7256@yookeroo>
References: <OFEB1252DC.D653C7C7-ON882577DE.0078DABB-862577DE.00792502@notes.teradyne.com>
	<1290083062.22575.9.camel@concordia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
In-Reply-To: <1290083062.22575.9.camel@concordia>
Cc: Steven_Lin@notes.teradyne.com, steven.lin@teradyne.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 18, 2010 at 11:24:22PM +1100, Michael Ellerman wrote:
> On Wed, 2010-11-17 at 16:03 -0600, steven.lin@teradyne.com wrote:
> > My application needs a fast way to access a specific physical DDR
> > memory region. The application runs on an MPC8548 PowerPC which has an
> > MMU. I've tried two approaches that are typical for Linux, mmap() and
> > using a kernel module that implements read()/write() into this region
> > and I'm finding that performance is very slow for both. It's a couple
> > orders of magnitude slower than, for example, copying a large buffer
> > from one place in the application's virtual memory to another place in
> > the application's virtual memory.
>=20
> The mmap() version should basically run at "full speed", at least once
> you've faulted the address range in.
>=20
> This specific DDR region isn't specifically slow is it ? :)

The other theory that springs to mind is whatever method you're using
to access the region enabling cacheing?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzlIgEACgkQaILKxv3ab8YFzgCZAVb16o9SJ9qHJFENd16FiRTU
Ct0An2GHVSgKYLsXFOkDqFUa+/rDiO+o
=Ao/d
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
