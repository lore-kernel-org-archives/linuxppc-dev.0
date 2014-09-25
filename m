Return-Path: <thierry.reding@gmail.com>
Received: from mail-wi0-x231.google.com (mail-wi0-x231.google.com
 [IPv6:2a00:1450:400c:c05::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB94C1A0929
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 17:38:06 +1000 (EST)
Received: by mail-wi0-f177.google.com with SMTP id q5so8782269wiv.16
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 00:38:03 -0700 (PDT)
Date: Thu, 25 Sep 2014 09:38:01 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2 17/22] s390/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
Message-ID: <20140925073800.GM12423@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-18-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="W4pDZ/VvazBYHhxQ"
In-Reply-To: <1411614872-4009-18-git-send-email-wangyijing@huawei.com>
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


--W4pDZ/VvazBYHhxQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 11:14:27AM +0800, Yijing Wang wrote:
[...]
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
[...]
> @@ -358,7 +358,7 @@ static void zpci_irq_handler(struct airq_struct *airq)
>  	}
>  }
> =20
> -int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
> +int zpci_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)

static?

--W4pDZ/VvazBYHhxQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI8ZYAAoJEN0jrNd/PrOhT54QAIN9jc2i8zDFXQP0O2xLX151
K/0a6f2Ke1ts4th35u5jkXxtnjEubc8RMuU2k+Dft0pOk1wQqfi7CmdJtG+MrGqI
IZ78syU0TLzw2I2IhhCW/qIrc0eK9gcVpY5FnYxNGNsErYVOHB5w2lqj65UXkrK1
KuKTi4wk7SBfs7D0I7UVe9CjiGte3h4Wkm0FExDPekBjlb+NheufDExalF1vv5VW
Y/Ers3FW9kjTCLWHf+wS7Sg7a/uq8PfTG3hkn7ja7ykCouBoheB+pb1OmV5boizz
/H9TvN+P3WCd3TCe0pz5qI8icntR/5V09HiM3OM1sGqwWopvZgKiw8RSXwJMKdb3
4NsDxyu6glUOMpuFyDxzQ+iC94LeTq1L4C4oTfrdMdCQetJQm1DxWQYo4iPy1Luz
cyWf37Gr7RoNuPlx++ONPfub8xDPP6LpDm7Jf1ztIuHNRnN0D/EYNP/3W6s2en4w
0n4URoSBn7blmJQPOKQ+oNkw295vAc0bSU+NlqjdnpMhJq/Aq+olHB4Of97IKXtk
7lLqyJAX6ISNs302AVES9Wch7UW6MWrlpxiQk3HkGZBvFExbGCTD806d0wr9+V9Y
XcvfTABfe5ycOd28a4HwZx0BpglxbMRwarqwdwhpA9H0500K4lmTPrzZLVY+B0AB
UxhsWg3u+nU6NtiAWuwY
=lpw6
-----END PGP SIGNATURE-----

--W4pDZ/VvazBYHhxQ--
