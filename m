Return-Path: <wsa@the-dreams.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E60E41A0DC6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 07:55:34 +1100 (AEDT)
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 632B014010F
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2014 07:55:33 +1100 (AEDT)
Date: Mon, 8 Dec 2014 21:55:20 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3] i2c: Driver to expose PowerNV platform i2c busses
Message-ID: <20141208205520.GA12715@katana>
References: <20141208063039.14356.34770.stgit@localhost.localdomain>
 <1418069595.4827.43.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
In-Reply-To: <1418069595.4827.43.camel@kernel.crashing.org>
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 09, 2014 at 07:13:15AM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2014-12-08 at 12:06 +0530, Neelesh Gupta wrote:
> > The patch exposes the available i2c busses on the PowerNV platform
> > to the kernel and implements the bus driver to support i2c and
> > smbus commands.
> > The driver uses the platform device infrastructure to probe the busses
> > on the platform and registers them with the i2c driver framework.
>=20
> Wolfram, what are you remaining objections here ? We need that in
> distros ASAP ...

Oh, I thought we agreed that you take it via powerpc. I still think this
is the best solution.

> I still maintain that it's not reasonable to hold driver for the
> additions of multi-byte smbus offsets. This is a new feature that will
> require changes to a number of existing bus and device drivers, so a
> very pervasive change, and which will be visible to user space, which
> means that drivers will need to continue supporting the "old" way at
> least for a while anyway...

Yeah, I agree on that. I am still unsure about the port-name binding,
but well, if it is needed to fit your PowerNV scheme...

> > Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> >=20
> > v2 -> v3:
> > - Added the device tree binding documentation for the driver.
> > - Sorted the ordering of this new driver added in Makefile.
> > - Removed populating the superfluous .owner field in 'struct driver'.

Thanks for the updates!


--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUhhA4AAoJEBQN5MwUoCm2EY0P/1iLRsSLPPyFV+mjyWVdGO9z
D8V5RTzThia+Fvg/y77Ksssps/so+74OTa8ygDtChuOhMWsM5UJtdxOROJ3rYXzN
Z0FizogQZLFQHidb+w6P6Cj3b0PhjCNQ2QE+ePX8NLuYjb88IkthadJjkRiVf7+/
tsR4rJnXuDrywkZeTsQEdvkijKTYTuBwtlYnOOGPO8jUij/diUv9BaP0fVTCV63T
pKNdOIGnwIzLVmj280V0jlrZ3FqF2K4g5ZFTpzFbcnV8GDVdRZhFgcQViWy7TgwS
uvVq6Pqkpq+nH1fQO74mJOuCSv+zyPB6TRJbwPVd0cT2Du3H7+9aqOa1Kn6K3Ju7
hnOUEfUruo652Jt0MAoaHSxmgLnSyziucMrN9+FQQpiKFcagOl85kMrGyRXK7xk7
riqRMHWoK9ghHtUdgIynbLyToSkABSAHtQRdUb++rZ69DO168n7GuBDc1D0i69Rt
6Hq1xEubUscjDFNwhGMOgpfQso6AJAiBsuUZ/UEz7f9peTvPqqNWOYZGCY5SMvY4
YqIaYdZUs3fYLs8Ig8dNswKALjJgrmIH7yWR0s3jxQZwFvo9DSCDbTxGN5qUXNEW
Cl5M/2OOpqlvOCxDxTs3xB1Zuk/t/TkeUP0zeIR+spoFhItI2NKjk6RlP0Hj/3/5
bhvwA2UDID6U51gkop7R
=lKq2
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
