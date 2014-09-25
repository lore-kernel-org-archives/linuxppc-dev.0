Return-Path: <thierry.reding@gmail.com>
Received: from mail-wi0-x232.google.com (mail-wi0-x232.google.com
 [IPv6:2a00:1450:400c:c05::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D5B01A0163
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 17:19:26 +1000 (EST)
Received: by mail-wi0-f178.google.com with SMTP id z2so8729083wiv.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 00:19:22 -0700 (PDT)
Date: Thu, 25 Sep 2014 09:19:20 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2 03/22] MSI: Remove the redundant irq_set_chip_data()
Message-ID: <20140925071919.GH12423@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-4-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mhjHhnbe5PrRcwjY"
In-Reply-To: <1411614872-4009-4-git-send-email-wangyijing@huawei.com>
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


--mhjHhnbe5PrRcwjY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2014 at 11:14:13AM +0800, Yijing Wang wrote:
> Currently, pcie-designware, pcie-rcar, pci-tegra drivers
> use irq chip_data to save the msi_chip pointer. They
> already call irq_set_chip_data() in their own MSI irq map
> functions. So irq_set_chip_data() in arch_setup_msi_irq()
> is useless.

Again, I think this should be the other way around. If drivers do
something that's already handled by the core, then the duplicate code
should be dropped from the drivers.

Thierry

--mhjHhnbe5PrRcwjY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI8H3AAoJEN0jrNd/PrOhD9gP/irz9NSH3coHma+k59CgfNee
Eadp8ruJoWHsk+kNc+VP4X8QUfFbawc4Y9GarISl2soj926zV/hj8I7CSKn7im1g
OEWOG1+IoZY+1142DUhZRfqgw+kPIsHL2nKRK6RJCWhpIxIrh1f7/LcSyrWUbS9r
7t6FJUljEAZ4oSmW8FDuK4hrK9s53zIKQkvv2zfbOv7sAvnYuJM4r5EteKEkxVqy
VEwvbqgS5Ccf4PKJKnISrCAV9z4H8kYF2PN0e7+8x9l6WOsdz5yEszOJmoREGMzG
eCUaBYi7Tl7jAqdQkJfEePdK7BotGIbuffF2j76j1TTgOKp2HEoMlTxLv9SldxMa
9NoNSP5NzJzSyK6Pawx84xkhKnMd5TWLD7IMcDvfcMIbQ+IZiXDnNjQ9diG3RjhT
zLyMRZc5MdOfL8ScPzrYYUATbIEFmJdB0rUZ6u9ivHdRsVqZ6pJbRz/C/QPfd92M
dDXoVvcRDGGgaM66PbfYykArWhGI+hPG4ip3t5CpA2KLqLm9BapvqSc0H6V9y5w8
nuBHS0pk3mojCR9naMzuOy0nqME7SU9QiOiMMvv6uZztE2y3udRmkZNHX32DSi7l
6YLq84EA/LyOtPp9jrRH1eKZLty5qyY2mO9Le46GAragc909SMnKpNAWJyV+RLLm
9fhn8sFnEUFKzDPptCkB
=WmVy
-----END PGP SIGNATURE-----

--mhjHhnbe5PrRcwjY--
