Return-Path: <alexander.steffen@infineon.com>
Received: from smtp11.infineon.com (smtp11.infineon.com
 [IPv6:2a00:18f0:1e00:4::5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yH6kg1QCMzDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 20:50:50 +1100 (AEDT)
From: <Alexander.Steffen@infineon.com>
To: <joe@perches.com>, <elfring@users.sourceforge.net>,
 <linux-integrity@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC: <James.Bottomley@HansenPartnership.comg>, <dan.carpenter@oracle.com>,
 <jarkko.sakkinen@linux.intel.com>, <andriy.shevchenko@linux.intel.com>,
 <benh@kernel.crashing.org>, <clabbe.montjoie@gmail.com>,
 <jgunthorpe@obsidianresearch.com>, <jsnitsel@redhat.com>,
 <kgold@linux.vnet.ibm.com>, <mpe@ellerman.id.au>, <nayna@linux.vnet.ibm.com>,
 <paulus@samba.org>, <PeterHuewe@gmx.de>, <stefanb@linux.vnet.ibm.com>,
 <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: RE: char-TPM: Adjustments for ten function implementations
Date: Wed, 18 Oct 2017 09:50:46 +0000
Message-ID: <026d582729b849b780fbaa06fb8bc79e@infineon.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <20171016183139.otyh3m5c5yurtmow@linux.intel.com>
 <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
 <20171017085124.pkrjzghcf5wmcydc@mwanda>
 <f9b35a67-bd7f-b140-bdc1-cb4886a6b1ea@users.sourceforge.net>
 <1508255833.3129.33.camel@HansenPartnership.com>
 <1508280210.6530.32.camel@perches.com>
 <bf7fc26c-bdc9-c752-72c7-f44c22f4a328@users.sourceforge.net>
 <1508318326.6806.1.camel@perches.com>
In-Reply-To: <1508318326.6806.1.camel@perches.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Wed, 2017-10-18 at 11:00 +0200, SF Markus Elfring wrote:
> > > The printk removals do change the objects.
> > >
> > > The value of that type of change is only for resource limited systems=
.
> >
> > I imagine that such small code adjustments are also useful for other
> systems.
>=20
> Your imagination and mine differ.
> Where do you _think_ it matters?
>=20
> For instance, nothing about
>=20
> 	sizeof(type)
> vs
> 	sizeof(*ptr)
>=20
> makes it easier for a human to read the code.

If it does not make it easier to read the code for you, then maybe you shou=
ld consider that this might not be true for all humans. For me, it makes it=
 much easier to see at a glance, that code like ptr=3Dmalloc(sizeof(*ptr)) =
is correct.

Alexander
