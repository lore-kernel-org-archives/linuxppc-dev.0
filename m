Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCrSm5qghzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 15:56:40 +1100 (AEDT)
Date: Wed, 1 Feb 2017 15:56:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: sjitindarsingh@gmail.com, benh@kernel.crashing.org, thuth@redhat.com,
 lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 00/11] KVM implementation of PAPR HPT resizing extension
Message-ID: <20170201045636.GT30639@umbus.fritz.box>
References: <20161220054907.9204-1-david@gibson.dropbear.id.au>
 <20170131221813.GA3305@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9r3HF47jptiQlX4s"
In-Reply-To: <20170131221813.GA3305@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--9r3HF47jptiQlX4s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 01, 2017 at 09:18:13AM +1100, Paul Mackerras wrote:
> On Tue, Dec 20, 2016 at 04:48:56PM +1100, David Gibson wrote:
> > Here is the KVM implementation for the proposed PAPR extension which
> > allows the runtime resizing of a PAPR guest's Hashed Page Table (HPT).
> >=20
> > Using this requires a guest kernel with support for the extension.
> > Patches for guest side support in Linux were posted earlier:
> >   https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-December/152164.=
html
> >=20
> > It also requires userspace (i.e. qemu) to intercept the HPT resizing
> > hypercalls and invoke the KVM ioctl()s to implement them.  This is
> > done instead of having KVM direclty intercept the hypercalls, so that
> > userspace can, if useful, impose additional restrictions on resizes:
> > for example it could refuse them entirely if policy for the VM
> > precludes resizing, or it could limit the size of HPT the guest can
> > request to meet resource limits.
> >=20
> > Patches to implement the userspace part of HPT resizing are proposed
> > for qemu-2.9, and can be found at:
> >   https://github.com/dgibson/qemu/tree/hpt-resize
> >=20
> > I'm posting these now, in the hopes that both these and the
> > corresponding guest side patches can be staged and merged for the 4.11
> > window.
>=20
> Thanks, series applied to my kvm-ppc-next branch.

Great.  Where can I grab that tree?

> Next time, please cc kvm-ppc@vger.kernel.org so I shows up in
> patchwork and I don't miss it.

Sorry, I hadn't realized that list existed.  Noted for future
reference.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9r3HF47jptiQlX4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkWp+AAoJEGw4ysog2bOS9LcP+QHPPJTo6FFkmiY7hp8UnN0u
dW8xfpsRC81sv7OW2IjpRJ5w9GafMNO/g68n124y7Df68Dg4ql3N27BdfzP5cs8/
JvU4F4BQGKwTMxzCrNK/OFif+mrYOmTCIEVIx+/QDZXLwI4FzxSHJ+eVT0IzXGyO
mK2DauA9ujuaCHVYGqDpcqw0MRjqnHX4lRWL4FodYEy08NApHyc8+SdYqS5sS85v
Y+DNSfbTwLV0KOY7PIBHi0liFqG1C035Mnp6obfgOg6HJwxrujDdmEK/G7FSFj72
kTOdYSQKUkZA9dBd5Q5996XAkUzwVxS2GrtD2nKdm4fOV3LEBUEYlKqwvzG9UQw+
ej5Eh7eLB4kjPbUeuQ1dd+IV/Ind0r3vMnpXZDxdkCNiPpQ1bjbf5jO+g0Lk2bQo
glICTe07wEGRXml3mT58vvt/IOAk3W07VivqD8LUFveinr+p71pNpEE1VmcXW4nW
W3sEBajb5Zydx6fg+ov4bUG5AyfRyt8XgNam2n6F01HHNmII7f2Q3GxM2Cjr2Gv2
ESbvPUYdOl/SvfW4W6lhm53NBENyK6UV02FO2EiEiGKolSQh5ooVtSFTfoKIdy/E
ixGw4XNLiWKUZgc5HXM5C6KgLIhItdkIk/t9+NbZQk0bm3/F8Po1bOcA0tv3VWTv
qS45usV8RszC6KoU+qpp
=IAgI
-----END PGP SIGNATURE-----

--9r3HF47jptiQlX4s--
