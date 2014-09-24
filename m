Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFDB11A017E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 13:52:42 +1000 (EST)
Message-ID: <54223FE8.4070101@huawei.com>
Date: Wed, 24 Sep 2014 11:52:08 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 00/21] Use MSI chip to configure MSI/MSI-X in all
 platforms
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
 <20140923210936.GC27117@google.com>
In-Reply-To: <20140923210936.GC27117@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Xinwei Hu <huxinwei@huawei.com>, Tony Luck <tony.luck@intel.com>,
 Ralf Baechle <ralf@linux-mips.org>, iommu@lists.linux-foundation.org,
 Wuyun <wuyun.wu@huawei.com>, linuxppc-dev@lists.ozlabs.org, "David S.
 Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014/9/24 5:09, Bjorn Helgaas wrote:
> On Fri, Sep 05, 2014 at 06:09:45PM +0800, Yijing Wang wrote:
>> This series is based Bjorn's pci-next branch + Alexander Gordeev's two patches
>> "Remove arch_msi_check_device()" link: https://lkml.org/lkml/2014/7/12/41
>>
>> Currently, there are a lot of weak arch functions in MSI code.
>> Thierry Reding Introduced MSI chip framework to configure MSI/MSI-X in arm.
>> This series use MSI chip framework to refactor MSI code across all platforms
>> to eliminate weak arch functions. It has been tested fine in x86(with or without
>> irq remap).
> 
> I see you plan some updates, so I'll look for a v2 posting after v3.17 releases.
> It will be great to get rid of some of those weak functions!

Thanks, I will send out the new version soon.

Thanks!
Yijing.

> 
> Bjorn
> 
> .
> 


-- 
Thanks!
Yijing
