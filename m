Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 463EB1A189E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Oct 2014 13:36:51 +1100 (EST)
Date: Tue, 14 Oct 2014 22:36:41 -0400 (EDT)
Message-Id: <20141014.223641.1750858832286185881.davem@davemloft.net>
To: wangyijing@huawei.com
Subject: Re: [PATCH v3 25/27] Sparc/MSI: Use MSI chip framework to
 configure MSI/MSI-X irq
From: David Miller <davem@davemloft.net>
In-Reply-To: <1413342435-7876-26-git-send-email-wangyijing@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
 <1413342435-7876-26-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 thierry.reding@gmail.com, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux@arm.linux.org.uk,
 joro@8bytes.org, x86@kernel.org, sebott@linux.vnet.ibm.com,
 xen-devel@lists.xenproject.org, arnab.basu@freescale.com, liviu@dudau.co.uk,
 arnd@arndb.de, konrad.wilk@oracle.com, cmetcalf@tilera.com,
 bhelgaas@google.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 thomas.petazzoni@free-electrons.com, huxinwei@huawei.com, tony.luck@intel.com,
 sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, iommu@lists.linux-foundation.org, david.vrabel@citrix.com,
 wuyun.wu@huawei.com, linuxppc-dev@lists.ozlabs.org, l.stach@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Yijing Wang <wangyijing@huawei.com>
Date: Wed, 15 Oct 2014 11:07:13 +0800

> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Acked-by: David S. Miller <davem@davemloft.net>
