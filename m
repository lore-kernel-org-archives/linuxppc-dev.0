Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 11/16] powerpc: add ps3 platform repository support
From: Michael Ellerman <michael@ellerman.id.au>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20061115180613.GC18856@lst.de>
References: <4554DAFC.1070804@am.sony.com>  <20061115180613.GC18856@lst.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-XnM4/ki7nexjvac4jm6h"
Date: Thu, 16 Nov 2006 11:12:54 +1100
Message-Id: <1163635974.8805.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-XnM4/ki7nexjvac4jm6h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-11-15 at 19:06 +0100, Christoph Hellwig wrote:
> On Fri, Nov 10, 2006 at 12:03:08PM -0800, Geoff Levand wrote:
> > + * make_first_field - Make the first field of a repository node name.
> > + * @text: Text portion of the field.
> > + * @index: Numeric index portion of the field.  Use zero for 'don't ca=
re'.
> > + *
> > + * This routine sets the vendor id to zero (non-vendor specific).
> > + * Returns field value.
> > + */
> > +
> > +static u64 make_first_field(const char *text, u64 index)
> > +{
> > +	u64 n;
> > +
> > +	strncpy((char *)&n, text, 8);
> > +	return ps3pf_vendor_id_none + (n >> 32) + index;
> > +}
>=20
> a strncpy into a const pointer doesn't make any sense.

It's from a const pointer into a u64.

It still doesn't make any sense though .. crazy hypervisor weirdness.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-XnM4/ki7nexjvac4jm6h
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFW60GdSjSd0sB4dIRAkqtAJ9sKqpdC3STZR+rsfAHsZDzIRElVACdGl5Z
DXEL8Uros6G8Nx1tllom6F4=
=JVCA
-----END PGP SIGNATURE-----

--=-XnM4/ki7nexjvac4jm6h--
