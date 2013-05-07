Return-Path: <dgibson@ozlabs.org>
Date: Tue, 7 May 2013 16:54:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 5/6] KVM: PPC: Add support for IOMMU in-kernel handling
Message-ID: <20130507065407.GT13692@truffula.fritz.box>
References: <1367825157-27231-1-git-send-email-aik@ozlabs.ru>
 <1367825157-27231-6-git-send-email-aik@ozlabs.ru>
 <20130507052933.GP13692@truffula.fritz.box>
 <51889663.5060909@ozlabs.ru>
 <20130507060240.GQ13692@truffula.fritz.box>
 <51889EE5.5050807@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="nNx5P6V1TPcCvZS+"
In-Reply-To: <51889EE5.5050807@ozlabs.ru>
Cc: kvm@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--nNx5P6V1TPcCvZS+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2013 at 04:27:49PM +1000, Alexey Kardashevskiy wrote:
> On 05/07/2013 04:02 PM, David Gibson wrote:
> > On Tue, May 07, 2013 at 03:51:31PM +1000, Alexey Kardashevskiy wrote:
> >> On 05/07/2013 03:29 PM, David Gibson wrote:
> >>> On Mon, May 06, 2013 at 05:25:56PM +1000, Alexey Kardashevskiy wrote:
[snip]
> >>>> +#define DRIVER_VERSION	"0.1"
> >>>> +#define DRIVER_AUTHOR	"Paul Mackerras, IBM Corp. <paulus@au1.ibm.co=
m>"
> >>>> +#define DRIVER_DESC	"POWERPC KVM driver"
> >>>
> >>> Really?
> >>
> >>
> >> What is wrong here?
> >=20
> > Well, it seems entirely unrelated to the rest of the changes,=20
>=20
>=20
> The patch adds a module parameter so I had to add those DRIVER_xxx.

Ah, ok.

> > and not obviously accurate.
>=20
> Let's fix it then. How? Paul signed it...

Fair enough then.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nNx5P6V1TPcCvZS+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlGIpQ8ACgkQaILKxv3ab8bw8wCeJIzUXP39MoqIIYNCRSM2lFms
MrwAnRUZcsWIXk+2a5fFzU8vr0zpCi6v
=x9Bz
-----END PGP SIGNATURE-----

--nNx5P6V1TPcCvZS+--
