Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9522B1A175D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 12:15:10 +1000 (EST)
Message-ID: <5424CBF1.4000000@huawei.com>
Date: Fri, 26 Sep 2014 10:14:09 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 17/22] s390/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-18-git-send-email-wangyijing@huawei.com>
 <20140925073800.GM12423@ulmo>
In-Reply-To: <20140925073800.GM12423@ulmo>
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

On 2014/9/25 15:38, Thierry Reding wrote:
> On Thu, Sep 25, 2014 at 11:14:27AM +0800, Yijing Wang wrote:
> [...]
>> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> [...]
>> @@ -358,7 +358,7 @@ static void zpci_irq_handler(struct airq_struct *airq)
>>  	}
>>  }
>>  
>> -int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>> +int zpci_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
> 
> static?

Yes, Will update.

> 


-- 
Thanks!
Yijing
