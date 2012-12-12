Return-Path: <andrew.murray@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 4D4F92C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2012 03:48:12 +1100 (EST)
Date: Wed, 12 Dec 2012 16:44:58 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: pci and pcie device-tree binding - range No cells
Message-ID: <20121212164458.GA17425@arm.com>
References: <50C5D387.90908@monstr.eu> <50C5F11D.9060006@gmail.com>
 <50C5FA3E.9030303@monstr.eu> <50C5FE0F.3050108@gmail.com>
 <20121210214127.D51773E0796@localhost> <50C85E7D.5080006@monstr.eu>
 <CACxGe6udeSbEfibC53v0wu8vFRE6K3Fd_P6EX-3JS9F2M=wUeA@mail.gmail.com>
 <CAPcvp5EJH-Q6wd7my+V+FUVE1=hzwMN-yOfHiukGvDmkcoRcsQ@mail.gmail.com>
 <20121212121912.GA2776@arm.com>
 <20121212133424.GA26280@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1.0
In-Reply-To: <20121212133424.GA26280@avionic-0098.adnet.avionic-design.de>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: Michal Simek <monstr@monstr.eu>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, Liviu.Dudau@arm.com,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 Rob Herring <robherring2@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 12, 2012 at 01:34:24PM +0000, Thierry Reding wrote:
> On Wed, Dec 12, 2012 at 12:19:12PM +0000, Andrew Murray wrote:
> > I've been working on a relatively architecture agnostic PCI host bridge=
 driver
> > and also wanted to avoid duplicating more generic DT parsing code for P=
CI
> > bindings.
> >=20
> > I've ended up with a patch which provides an iterator for returning res=
ources
> > based on the the typical 'ranges' binding. This has ended up living in
> > drivers/of/address.c. I originally started out in drivers/of/pci.c and
> > drivers/pci/pci-of.c but found there were good (and static) implementat=
ions in
> > drivers/of/address.c which can be reused (e.g. of_bus_pci_get_flags,
> > bus->count_cells).
> >=20
> > I'm not just ready to post it - but can do before early next week if yo=
u can
> > wait.
>=20
> I already posted a similar patch[0] as part of a larger series to bring
> DT support to Tegra PCIe back in July. I suppose what you have must be
> something pretty close to that. Most of the stuff that had me occupied
> since then should be done soon and I was planning on resurrecting the
> series one of these days.

Thanks for the reference. I've submitted my patch, it's along the lines of =
your
existing patch.

I'm happy to take the best bits from both, drop mine, etc.

Andrew Murray
