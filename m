Return-Path: <thierry.reding@gmail.com>
Received: from mail-wg0-x22f.google.com (mail-wg0-x22f.google.com
 [IPv6:2a00:1450:400c:c00::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2CA4D1A0199
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 17:42:41 +1000 (EST)
Received: by mail-wg0-f47.google.com with SMTP id y10so7636522wgg.18
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 00:42:37 -0700 (PDT)
Date: Thu, 25 Sep 2014 09:42:36 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2 00/22] Use MSI chip framework to configure MSI/MSI-X
 in all platforms
Message-ID: <20140925074235.GN12423@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="O27Gs9jTTFWz3gAR"
In-Reply-To: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Xinwei Hu <huxinwei@huawei.com>, Tony Luck <tony.luck@intel.com>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 iommu@lists.linux-foundation.org, David Vrabel <david.vrabel@citrix.com>,
 Wuyun <wuyun.wu@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, Lucas Stach <l.stach@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--O27Gs9jTTFWz3gAR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 11:14:10AM +0800, Yijing Wang wrote:
> This series is based Bjorn's pci/msi branch
> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/msi
>=20
> Currently, there are a lot of weak arch functions in MSI code.
> Thierry Reding Introduced MSI chip framework to configure MSI/MSI-X in ar=
m.
> This series use MSI chip framework to refactor MSI code across all platfo=
rms
> to eliminate weak arch functions. Then all MSI irqs will be managed in a=
=20
> unified framework. Because this series changed a lot of ARCH MSI code,
> so tests in the platforms which MSI code modified are warmly welcomed!

Apart from the comments to the individual patches I very much like where
this is going. Thanks for taking care of this.

Thierry

--O27Gs9jTTFWz3gAR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI8drAAoJEN0jrNd/PrOhRSAQALsX6+rt+ih0Gd1v6P/pa7qN
OXrKB5iUQqBdwt1YLNoZ55Ojb03D1gWrXOV4DE2Ot+oWcChhDHqOflN7mOfNHLwj
94ZiLJMuHN97GQPNxto1U+ExV52tdbA8FIUIxXgeIV+PeDB55N/NQjJPXOLsLj/3
8yDXEOE3ZTdLDCNCFPBO4NFSRSvzTMkl4He0IOcMTDqom0YZfHzLb+pJR0DPNq0n
gpUb03/YTMlSgjIM9Ltq2wb5AdttZeJ4+MG7k/gyLJjFJr178R1szKz23l7cYZfq
7TowM+iBQV/g3v5l/TabQOeBQDYqIl/2iSJAxc17ECtoxrW1SqSckRJfTqcPmcPi
r0vplvHDqRXBrv+NH92zhjSts8N5nPZMjiDdSknrOJwJUFFQku8U/2A/XMX3SRxn
H+BbOXdut+fvidu7HPtrEqlfUIK9Lvh0l8XfnBoeZdLOnZoQV4wI9NBSH4D4HLpA
o/H5Cq5xh6o2xQFABJHoFOIdMEz5NoWZ8BPiqQJ5nWn9ErGrBmbKcll6S2rIRqZP
/UhLXKnd3ju7cQF1kH6gu2zL8l2mWIEISUZWJ1dPsc51Y4164W6olvTZ95BGmLQc
QunHexGBsu0mVlTLtcfVey5K9+m8zcJQel6KThgh2MSBNt54p6IEuLT4fS3e4mXE
VE4kNZ+YiwcZhdZXalp+
=IFC0
-----END PGP SIGNATURE-----

--O27Gs9jTTFWz3gAR--
