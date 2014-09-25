Return-Path: <thierry.reding@gmail.com>
Received: from mail-wg0-x231.google.com (mail-wg0-x231.google.com
 [IPv6:2a00:1450:400c:c00::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C9611A1632
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 17:26:25 +1000 (EST)
Received: by mail-wg0-f49.google.com with SMTP id x12so7468567wgg.20
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 00:26:21 -0700 (PDT)
Date: Thu, 25 Sep 2014 09:26:20 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2 06/22] PCI/MSI: Introduce weak arch_find_msi_chip() to
 find MSI chip
Message-ID: <20140925072619.GI12423@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-7-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wZdghQXYJzyo6AGC"
In-Reply-To: <1411614872-4009-7-git-send-email-wangyijing@huawei.com>
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


--wZdghQXYJzyo6AGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2014 at 11:14:16AM +0800, Yijing Wang wrote:
> Introduce weak arch_find_msi_chip() to find the match msi_chip.
> Currently, MSI chip associates pci bus to msi_chip. Because in
> ARM platform, there may be more than one MSI controller in system.
> Associate pci bus to msi_chip help pci device to find the match
> msi_chip and setup MSI/MSI-X irq correctly. But in other platform,
> like in x86. we only need one MSI chip, because all device use
> the same MSI address/data and irq etc. So it's no need to associate
> pci bus to MSI chip, just use a arch function, arch_find_msi_chip()
> to return the MSI chip for simplicity. The default weak
> arch_find_msi_chip() used in ARM platform, find the MSI chip
> by pci bus.

Can't x86 simply set the bus' .msi field anyway? It would seem to be
easy to do and unifies the code rather than driving it further apart
using even more of the __weak functions.

Thierry

--wZdghQXYJzyo6AGC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI8ObAAoJEN0jrNd/PrOhuC4P/jIBmvnDAEtAA8p9/uMyo4ub
35EbcR8vyvkUOhtovW5OYqkxRnKAfsYNHAbYYijRRWopeBkmqYj1EiW8F3M3MbKT
FD+87Kx/0mNqy1mNdoPnIttpaCyY9igbhmeWhE5gFFqI4L715gT4AVg7tG79gsas
BObGQrGqdsEcdHsMae9wIm6X46Q2HcECiOp5T619C7P6/4DRXoQ6CreiwtWgh8GN
HdDemrevFvVZI72ceWPPPSY813vykzLhvxbiMhjhiYtZSbtqmYJoNQBbeQIlhfYV
mdIBuGWQlSAyy4+IZq/IBJ/lO4BtU4zevDvSCOnKhCUlHAZ7qNpxLtDXaZmxRQ1W
/9BeZHt+IDeev7rXTA97oQXAwzbAabafN1FWyCUWZEq28xIYmAqQZeFA9+KKRQQm
QMs10F3xpcayjlUXPNp7pLoWgcffcb0g8YocMo4DdMgMFQ9Pnx7jIrQ9Z46n4o+i
u2Qb275YAwisvL1ol3S2lZ+19CdVEwp+ly/66aYviHzVYeDm2C11myPCbfCbNcPg
M/qS6KwZzn+LyyCiLT0dmcm90UTIPZ7uw0sbwcVbq80skjhZxLT5NS7xHYnP/znG
62a/6pxngsPcnk+b7pv2htjbxkKDjJkpn8kXGiR6sGwun0b7HheNwzanLbDPs/7B
3QkCbl7txteq7GjETQqt
=LNzZ
-----END PGP SIGNATURE-----

--wZdghQXYJzyo6AGC--
