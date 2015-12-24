Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A2141A01EB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Dec 2015 22:20:18 +1100 (AEDT)
Date: Thu, 24 Dec 2015 21:38:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: paulus@samba.org, benh@kernel.crashing.org, bharata@linux.vnet.ibm.com,
 lvivier@redhat.com, thuth@redhat.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 0/3] Prototype PAPR hash page table resizing (guest side)
Message-ID: <20151224103844.GB3011@voom.redhat.com>
References: <1450761298-12172-1-git-send-email-david@gibson.dropbear.id.au>
 <567BB96D.6050504@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+5G7L20VUoXZHCOn"
In-Reply-To: <567BB96D.6050504@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--+5G7L20VUoXZHCOn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 24, 2015 at 02:52:53PM +0530, Anshuman Khandual wrote:
> On 12/22/2015 10:44 AM, David Gibson wrote:
> > I've discussed with Paul and Ben previously the possibility of
> > extending PAPR to allow changing the size of a running guest's hash
> > page table (HPT).  This would allow for much more flexible memory
> > hotplug, since the HPT wouldn't have to be sized in advance for the
> > maximum possible memory size of the guest.
>=20
> Does it include reducing the size of HPT as well ?

It does, but that could fail with H_PTEG_FULL if there's a collision
between bolted entries in the reduced table.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+5G7L20VUoXZHCOn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWe8s0AAoJEGw4ysog2bOS+JcP/AodNGZgUqkyhuY2DqDP7ayM
ANREasYPfXTFokSCrzgDdpD71lzYVpcye1nA8FfKuMQRCFKAN9T5vSWAvSUKDKk1
Zg3242FDkj8XBnvkeu1SxqUKoGXJq4dGMB2n0qirrJkRRuCYsKlnU1/ZWGWUZjBw
/ZV4nNZReyqfJOx3IZuvTlhB7n6tkOSVUG9wSTBs0NrJy1pd7EGtBt3geXH680lQ
WlCEtgrfnaEJ/bj1Ajx0Vt+X/t3nTMX/Nxk/gxsZa9/qhSClg6Db9m6UTJeRRsCw
olfrubyorNDkJjWpUB45y4WgWSIPPkM4NYxOzPFyx7xfNGkXmk0H94kn4BV4ZNVm
1EMpp2c7GflpvZmHsNJQXcnzFmFO3yhYVg3uxBDS+JW++k9SSoeJnDPIsjzRX2gp
BVz3vZo2atXQ6It09KRIjd90PxxEFrb6VHhmaXooNg4Cf2mf/QAnY0RlQPjuK1n/
t79AhuVy1k9RmdWsUekVLlYLestcK27/ualUHlB8hq4N1H8r0NDHRMBRgTux5p7B
SuxDzvE9tMTsJGAUR9IsIjYuzbOB27LCwVAnlaqUJ9Cyo7o9PFYwUjLqinnGBU10
bx+ZnqcQN3iaBbw9gqkYw81CIpcG4qvuwA+xvswwgQ93C5qhRTq/WHT8MuqdULsi
q1+Emjv2vti4DpLz8vMW
=Yd1F
-----END PGP SIGNATURE-----

--+5G7L20VUoXZHCOn--
