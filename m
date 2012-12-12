Return-Path: <thierry.reding@avionic-design.de>
Date: Wed, 12 Dec 2012 14:34:24 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: pci and pcie device-tree binding - range No cells
Message-ID: <20121212133424.GA26280@avionic-0098.adnet.avionic-design.de>
References: <50C5D387.90908@monstr.eu> <50C5F11D.9060006@gmail.com>
 <50C5FA3E.9030303@monstr.eu> <50C5FE0F.3050108@gmail.com>
 <20121210214127.D51773E0796@localhost> <50C85E7D.5080006@monstr.eu>
 <CACxGe6udeSbEfibC53v0wu8vFRE6K3Fd_P6EX-3JS9F2M=wUeA@mail.gmail.com>
 <CAPcvp5EJH-Q6wd7my+V+FUVE1=hzwMN-yOfHiukGvDmkcoRcsQ@mail.gmail.com>
 <20121212121912.GA2776@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
In-Reply-To: <20121212121912.GA2776@arm.com>
Cc: Michal Simek <monstr@monstr.eu>, linux-pci@vger.kernel.org,
 devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
 Rob Herring <rob.herring@calxeda.com>, Rob Herring <robherring2@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2012 at 12:19:12PM +0000, Andrew Murray wrote:
> On Wed, Dec 12, 2012 at 10:49 AM, Grant Likely wrote:
> > On Wed, Dec 12, 2012 at 10:37 AM, Michal Simek <monstr@monstr.eu<mailto=
:monstr@monstr.eu>> wrote:
> > > On 12/10/2012 10:41 PM, Grant Likely wrote:
> > >> drivers/pci/pci-of.c would be good. I'd also accept drivers/of/pci.c
> > >> which might actually be a good idea in the short term so that it gets
> > >> appropriate supervision while being generalized before being moved i=
nto
> > >> the pci directory.
> > >
> > > Ben: Are you willing to move that ppc code to this location?
> > > It is probably not good idea that I should do it when I even don't ha=
ve
> > > hardware available for testing (Asking someone else).
> >=20
> > You're a clever guy, you are more than capable of crafting the patch,
> > even if you can't test on hardware. :-)
> >=20
> > I refactored most of the OF support code without having access to most
> > of the affected hardware. Once I got the changes out there for review
> > I also asked for spot testing before getting it into linux-next for
> > even more testing.
>=20
> I've been working on a relatively architecture agnostic PCI host bridge d=
river
> and also wanted to avoid duplicating more generic DT parsing code for PCI
> bindings.
>=20
> I've ended up with a patch which provides an iterator for returning resou=
rces
> based on the the typical 'ranges' binding. This has ended up living in
> drivers/of/address.c. I originally started out in drivers/of/pci.c and
> drivers/pci/pci-of.c but found there were good (and static) implementatio=
ns in
> drivers/of/address.c which can be reused (e.g. of_bus_pci_get_flags,
> bus->count_cells).
>=20
> I'm not just ready to post it - but can do before early next week if you =
can
> wait.

I already posted a similar patch[0] as part of a larger series to bring
DT support to Tegra PCIe back in July. I suppose what you have must be
something pretty close to that. Most of the stuff that had me occupied
since then should be done soon and I was planning on resurrecting the
series one of these days.

Thierry

[0]: https://patchwork.kernel.org/patch/1244451/

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQyIfgAAoJEN0jrNd/PrOhFsIQALy+Bnja2iVLAKqdX7H3ITNx
1DWh1zbQ59ZE9Whag1bS3ZU9C4qNLUhOiNxlnDzK6wpEL6m7uaCmO2CVtDjVXl3c
mOMrfa4Y+Yzxs7/jy6t2PYzxoPUSbE5hp75KpKyvW1vb3TCUHunybxSJ7Yk8VWJC
5l2adBsqlnD9qDl/hiJOM+CVIcMyaNn9WwXtpX1/8LCHq4Q1oG0rgz+ngbms1Ya4
yVN0FUZ6DZ/OUxTrPBedqN7FcB0FuATa+qyBI6nhG3ILAhkrWbsyYsOiPM3sVhhE
i74TTs5cqVy7TKcDpu430Mn0hXR6Pd9ICIcioBwy0SydYy8NAxduiH4ZXz0wvDI/
tGCBJ5R7+Qz2hpB/os8e4wh8ydq/tSiItdCmt2MHY5UuiVNdP1xAHSXcSQ0H4qE2
RtJ7I6Y4vSohQGQmCl7FIgXmXSEMUQ4og96/vpoDvkUk3mdStWtyXdq74prig+nM
QsfeSc4n56L84SEkvnUTB3IWC15hR25YmNjRqZrurm+gfm0M7k9SoxpfOn0fl8eQ
m9RiP/sjNyeBLdRtlPczClJe9Wd7wF0a+aqoonJNgEZyhNkBH3rZjXZQlViPlVaE
JaZYJzPyzaclzQmlnxQAekxAz1BD1Z8ugBrWuxFNjUJHyd/itUrg7UOlqr+rq/az
L3OrozmnuKVCZp+yFYA4
=W+xV
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
