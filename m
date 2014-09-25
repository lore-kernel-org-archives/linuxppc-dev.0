Return-Path: <thierry.reding@gmail.com>
Received: from mail-we0-x236.google.com (mail-we0-x236.google.com
 [IPv6:2a00:1450:400c:c03::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F1AC1A007F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 17:36:15 +1000 (EST)
Received: by mail-we0-f182.google.com with SMTP id u57so5520472wes.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 00:36:11 -0700 (PDT)
Date: Thu, 25 Sep 2014 09:36:09 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2 14/22] MIPS/Xlp/MSI: Use MSI chip framework to
 configure MSI/MSI-X irq
Message-ID: <20140925073608.GK12423@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-15-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6K2R/cS9K4qvcBNq"
In-Reply-To: <1411614872-4009-15-git-send-email-wangyijing@huawei.com>
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


--6K2R/cS9K4qvcBNq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 11:14:24AM +0800, Yijing Wang wrote:
> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

Nit: s/irq/IRQ/ in the above.

> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  arch/mips/pci/msi-xlp.c |   14 ++++++++++++--
>  1 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/pci/msi-xlp.c b/arch/mips/pci/msi-xlp.c
> index e469dc7..6b791ef 100644
> --- a/arch/mips/pci/msi-xlp.c
> +++ b/arch/mips/pci/msi-xlp.c
> @@ -245,7 +245,7 @@ static struct irq_chip xlp_msix_chip =3D {
>  	.irq_unmask	=3D unmask_msi_irq,
>  };
> =20
> -void arch_teardown_msi_irq(unsigned int irq)
> +void xlp_teardown_msi_irq(unsigned int irq)

Should this not be static now as well?

Thierry

--6K2R/cS9K4qvcBNq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI8XoAAoJEN0jrNd/PrOhrs4P/Rg10uO2/sCyBwOPDpHaskVO
8blYsnipag0xv7pyGtAeiEVLgpzcQpv+zjXPmti+R1qI1OVkUXblvYhNtz/CDMvg
AN6CaoZI3llRg3fZwiayj3m/i1HpiXTPqYPK3sWanCUMmZJe73eUj8zMt6bH7yPG
WsuUwWTrc2hcscIDucigcNopQ0fuh0vLYLWgiZe+qJdJIrvGkvGN4h0pHuqIkk0o
DUyMUme8HOL1irxSWYnnmkTPx3TOAWDn7VJVxJgpIKEG0A/X1GCi/4wCkMMxtuxH
1V0aRu/k9AsOR5BVDROfyZCHvuTVLZeXP54ehWxAyA1GwS55Z36FNsl/JLtZ2WhO
95CX6ac9NMDLgmGr9W19SAffXn47Yy/1fvK5zq0F+taK005ajIxufmnoSVrzZsH8
dS8MoFslKB8B2EKW5874CFVUKGx5hZTARp12WWvTfJehLTYfJNpSpdjRdI7LBggj
/PNzvpDkiwwSVzXcJUU45wOZvaS0ImoH3Xn2GF91D/kO+jfFc52lI8Tv8Ixw7Hgl
pJObojrzrQJe20K2NJP9xuCNXUXiI0/EbfwZf/MxE5u/FSxigS8vajMY8CFMlQ5N
4sSi2qWsKa2ZrGMo5dyDfblWSjy1U1O752LQXn+8ddng18wDV/tk/tzZU0Xsywy6
jGgaMyNaRi22AESZhUqv
=xvjk
-----END PGP SIGNATURE-----

--6K2R/cS9K4qvcBNq--
