Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 528661A009F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 12:19:43 +1000 (EST)
Message-ID: <5424CBD6.1010807@huawei.com>
Date: Fri, 26 Sep 2014 10:13:42 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 15/22] MIPS/Xlr/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-16-git-send-email-wangyijing@huawei.com>
 <20140925073700.GL12423@ulmo>
In-Reply-To: <20140925073700.GL12423@ulmo>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Xinwei Hu <huxinwei@huawei.com>, Tony Luck <tony.luck@intel.com>, Sergei
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

On 2014/9/25 15:37, Thierry Reding wrote:
> On Thu, Sep 25, 2014 at 11:14:25AM +0800, Yijing Wang wrote:
> [...]
>> diff --git a/arch/mips/pci/pci-xlr.c b/arch/mips/pci/pci-xlr.c
> [...]
>> @@ -214,11 +214,11 @@ static int get_irq_vector(const struct pci_dev *dev)
>>  }
>>  
>>  #ifdef CONFIG_PCI_MSI
>> -void arch_teardown_msi_irq(unsigned int irq)
>> +void xlr_teardown_msi_irq(unsigned int irq)
>>  {
>>  }
>>  
>> -int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>> +int xlr_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> 
> Can both of these now be static?
Yes, Will update.

> 
> Thierry
> 


-- 
Thanks!
Yijing
