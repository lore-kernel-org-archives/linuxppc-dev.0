Return-Path: <thierry.reding@gmail.com>
Received: from mail-wg0-x230.google.com (mail-wg0-x230.google.com
 [IPv6:2a00:1450:400c:c00::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E37181A1792
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 17:37:06 +1000 (EST)
Received: by mail-wg0-f48.google.com with SMTP id x13so4235401wgg.19
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 00:37:03 -0700 (PDT)
Date: Thu, 25 Sep 2014 09:37:01 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2 15/22] MIPS/Xlr/MSI: Use MSI chip framework to
 configure MSI/MSI-X irq
Message-ID: <20140925073700.GL12423@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-16-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="nrM5Z5VIJgwP9LWp"
In-Reply-To: <1411614872-4009-16-git-send-email-wangyijing@huawei.com>
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


--nrM5Z5VIJgwP9LWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 11:14:25AM +0800, Yijing Wang wrote:
[...]
> diff --git a/arch/mips/pci/pci-xlr.c b/arch/mips/pci/pci-xlr.c
[...]
> @@ -214,11 +214,11 @@ static int get_irq_vector(const struct pci_dev *dev)
>  }
> =20
>  #ifdef CONFIG_PCI_MSI
> -void arch_teardown_msi_irq(unsigned int irq)
> +void xlr_teardown_msi_irq(unsigned int irq)
>  {
>  }
> =20
> -int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> +int xlr_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)

Can both of these now be static?

Thierry

--nrM5Z5VIJgwP9LWp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI8YcAAoJEN0jrNd/PrOhmbYP/ikLBs/f/C3q0Ah+1wm0yIQ9
biLioTIcSkRAsIfmKvheDIwFqrlfVwxThhAFT1+1x9N/KgeZ0hTm7/ZzogCQEn9J
J90nv0Y1KRdY/exT1wfgVEFtITGMGqDKTScawCJSoqc/4iswAtYkap3QdftgmyDU
acFImPmiT5rTaF3oQXhgNTgRcMMsdGOYJg/64K0snGcBGCNDYr4ZutMiEzof/G7O
w5KUk61xP+tvpYWRebsG/ivvFVWXNwVnpAOPAq+j6ziVxLlFLvY/r7QZ0Z95kSTj
AqufUg6h2cePrzW3VGxKJ5HL0eLS43pMofUkRFqcNv/BEeE8ZEg5wd2mNCtAroXb
fG5+KClUrEYZ28WO5d7Bagvekb00O2SYJ6HQW9WoASguiLfMMGa0g9w8SxmES0Gv
axepd0VObagoL/0lUjvSs73S39kzWsShRysZ9hCEsox1Xt3kinX3wwIP+k97dsKC
LAyXKNzxzU5xtlsZONRwRx2SsBRnUApH6CgDE5SOBgSAM+Juuk/e4NES7iTHW1iA
7DrbU7XWcMc/SLbIanZv3gig1WuNUR011kUZ9cerQpTMZ5JX+pR/f59jbtgexuEt
2lqvEs5pj2RZfiZy+pl21B1hMz7UPuQm8Hw0NMsXQP9wPcDwLzYAqT7uhHdaBhLV
4rVgrCyYNcw+4+MK/Nhv
=crca
-----END PGP SIGNATURE-----

--nrM5Z5VIJgwP9LWp--
