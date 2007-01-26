Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: Michael Ellerman <michael@ellerman.id.au>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20070125.135515.106769311.davem@davemloft.net>
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125215307.GB3126@kroah.com>
	<20070125.135515.106769311.davem@davemloft.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-CUIBmG/ZU/0/1bkByWZA"
Date: Fri, 26 Jan 2007 12:05:07 +1100
Message-Id: <1169773507.25005.22.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: greg@kroah.com, kyle@parisc-linux.org, linuxppc-dev@ozlabs.org,
	brice@myri.com, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, ebiederm@xmission.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-CUIBmG/ZU/0/1bkByWZA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-01-25 at 13:55 -0800, David Miller wrote:
> From: Greg KH <greg@kroah.com>
> Date: Thu, 25 Jan 2007 13:53:07 -0800
>=20
> > On Thu, Jan 25, 2007 at 07:34:07PM +1100, Michael Ellerman wrote:
> > > OK, here's a first cut at moving ops based MSI into the generic code.=
 I'm
> > > posting this now to make sure I'm not heading off into the weeds.
> > >=20
> > > The fifth patch contain the guts of it, I've included the MPIC and
> > > RTAS backends as examples. In fact they actually work.
> > >=20
> > > In order to smoothly merge this with the old MSI code, the two will n=
eed to
> > > coexist in the tree for at least a few commits, so I've added (invisi=
ble)
> > > Kconfig symbols to allow that.
> > >=20
> > > I plan to merge the Intel code by:
> > >  * copying it into drivers/pci/msi/intel.c with zero changes.
> > >  * providing a minimal shim to connect the ops code to the intel code=
.
> > >  * at this point the code should be functional but ugly as hell.
> > >  * via a longish series of patches, adapt the intel code to better ma=
tch
> > >    the new ops code.
> > >  * this should allow us to bisect through to find any mistakes.
> > >=20
> > > If people think that's crazy and or stupid please let me know :)
> >=20
> > At first glance, this looks sane.  I'll apply the first 4 patches to my
> > trees, and hold off on the rest until you have the intel patches
> > finished.
>=20
> I'll also look into a sparc64 implementation as soon as I find the
> time.

That'd be great. The more backends we have the more likely we are to
find the bugs and bogosities in my design.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-CUIBmG/ZU/0/1bkByWZA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFuVPDdSjSd0sB4dIRAnZfAKCx4n/AveHv1yUblkpofPN80v+wjwCggPy6
t6+KSsWjeJE5HnpOgiRFxQs=
=5RKq
-----END PGP SIGNATURE-----

--=-CUIBmG/ZU/0/1bkByWZA--
