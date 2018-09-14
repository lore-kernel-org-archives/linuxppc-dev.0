Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BG4Y19C3zF314
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 10:05:32 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8E04XnC120355
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 20:05:30 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mfw0j31bc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 20:05:30 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Fri, 14 Sep 2018 01:05:28 +0100
Date: Fri, 14 Sep 2018 10:05:20 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 oohall@gmail.com
Subject: Re: [PATCH] MAINTAINERS: Add PPC contacts for PCI core error handling
References: <153677132617.23091.12307288405707171077.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180912165846.GH118330@bhelgaas-glaptop.roam.corp.google.com>
 <94b8929d44af6dd965600b7d159458312d500582.camel@russell.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
In-Reply-To: <94b8929d44af6dd965600b7d159458312d500582.camel@russell.cc>
Message-Id: <20180914000520.GA7655@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 13, 2018 at 12:26:55PM +1000, Russell Currey wrote:
> On Wed, 2018-09-12 at 11:58 -0500, Bjorn Helgaas wrote:
> > On Wed, Sep 12, 2018 at 11:55:26AM -0500, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > >=20
> > > The original PCI error recovery functionality was for the powerpc-spe=
cific
> > > IBM EEH feature.  PCIe subsequently added some similar features, incl=
uding
> > > AER and DPC, that can be used on any architecture.
> > >=20
> > > We want the generic PCI core error handling support to work with all =
of
> > > these features.  Driver error recovery callbacks should be independen=
t of
> > > which feature the platform provides.
> > >=20
> > > Add the generic PCI core error recovery files to the powerpc EEH
> > > MAINTAINERS entry so the powerpc folks will be copied on changes to t=
he
> > > generic PCI error handling strategy.
> >=20
> > I really want to make sure the powerpc folks are plugged into any PCI c=
ore
> > error handling discussions.  Please let me know if there's a better way
> > than this patch, or if there are other people who should be added.
>=20
> I think this patch is definitely a good idea.
>=20
> Alongside this (whether you want to include it in your patch or not, Bjor=
n),
> Sam Bobroff should replace myself as maintainer.  He's been very active i=
n fixing,
> reworking and reviewing in EEH land and will probably do a better job of =
keeping
> his finger on the pulse of the generic PCI error handling code than I did.
>=20
> - Russell

That's fine with me. You can add me or let me know if I should send a
patch.

Sam.

>=20
> >=20
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> > >  MAINTAINERS |    4 ++++
> > >  1 file changed, 4 insertions(+)
> > >=20
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 7e10ba65bfe4..d6699597fd89 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -11202,6 +11202,10 @@ PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
> > >  M:	Russell Currey <ruscur@russell.cc>
> > >  L:	linuxppc-dev@lists.ozlabs.org
> > >  S:	Supported
> > > +F:	Documentation/PCI/pci-error-recovery.txt
> > > +F:	drivers/pci/pcie/aer.c
> > > +F:	drivers/pci/pcie/dpc.c
> > > +F:	drivers/pci/pcie/err.c
> > >  F:	Documentation/powerpc/eeh-pci-error-recovery.txt
> > >  F:	arch/powerpc/kernel/eeh*.c
> > >  F:	arch/powerpc/platforms/*/eeh*.c
> > >=20
>=20

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlua+zEACgkQMX8w6AQl
/iKOcQf+JdfQFAngmcHC2C0vnnnEQQqLURa4IOJ1v4MhPTFoPBNoAaFuXXTeCC/L
6UEq5ZWULO+9LjgcDrXyzB30dFLv3o+Vdy/atZqogaiAFdFn77IQoO2IQJkZyA1v
oS1Vd5YbepFuJyxSX1lSlV5aljuUQkcc7QRQ93w3j/j6KsRqJiyjCpI782ANZFtY
CvomFGtSfdQgEVC/4VfXSIs4ZSbvB8LmprXWnIVmPTuw7gnkVJGpLACmmsLcwuvf
bRZmVvveTvoyfVzJV9PCifKLJhojr1mfgtIbmQ9UWdWfjELnvKle9zAnilrppBmL
+iPh3HV5N0DSOfeYraEGzM5F7DQO0A==
=fTc4
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
