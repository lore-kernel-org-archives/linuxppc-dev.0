Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (unknown [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F4C31A0006
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Sep 2014 12:33:45 +1000 (EST)
Message-ID: <54277327.6070500@huawei.com>
Date: Sun, 28 Sep 2014 10:32:07 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 00/22] Use MSI chip framework to configure MSI/MSI-X
 in all platforms
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <20140925074235.GN12423@ulmo> <20140925144855.GB31157@bart.dudau.co.uk>
 <20140925164937.GB30382@ulmo> <20140925171612.GC31157@bart.dudau.co.uk>
 <542505B3.7040208@huawei.com> <20140926085430.GG31106@ulmo>
 <20140926090537.GH31106@ulmo>
In-Reply-To: <20140926090537.GH31106@ulmo>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, Bharat.Bhushan@freescale.com,
 xen-devel@lists.xenproject.org, arnab.basu@freescale.com,
 Arnd Bergmann <arnd@arndb.de>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Liviu Dudau <liviu@dudau.co.uk>, Tony Luck <tony.luck@intel.com>, Sergei
 Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, iommu@lists.linux-foundation.org,
 David Vrabel <david.vrabel@citrix.com>, Wuyun <wuyun.wu@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, "David S.
 Miller" <davem@davemloft.net>, Lucas Stach <l.stach@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014/9/26 17:05, Thierry Reding wrote:
> On Fri, Sep 26, 2014 at 10:54:32AM +0200, Thierry Reding wrote:
> [...]
>> At least for Tegra it's trivial to just hook it up in tegra_pcie_scan_bus()
>> directly (patch attached).
> 
> Really attached this time.
> 
> Thierry
> 

It looks good to me, so I will update the arm pci hostbridge driver to assign
pci root bus the msi chip instead of current pcibios_add_bus(). But for other
platforms which only have a one msi chip, I will kept the arch_find_msi_chip()
temporarily for more comments, especially from Bjorn.

Thanks!
Yijing.

-- 
Thanks!
Yijing
