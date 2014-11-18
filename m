Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C7961A01C9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 11:55:48 +1100 (AEDT)
Message-ID: <546A98F5.8080506@huawei.com>
Date: Tue, 18 Nov 2014 08:55:17 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH 14/16] arm/PCI: Introduce pci_get_domain_nr()
References: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
 <1416219710-26088-15-git-send-email-wangyijing@huawei.com>
 <20141117120839.GA22241@e102568-lin.cambridge.arm.com>
In-Reply-To: <20141117120839.GA22241@e102568-lin.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"
Cc: Liviu Dudau <liviu@dudau.co.uk>, Tony Luck <tony.luck@intel.com>,
 Russell King <linux@arm.linux.org.uk>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "huxinwei@huawei.com" <huxinwei@huawei.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Wuyun <wuyun.wu@huawei.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>  
>> -	bus->domain_nr = domain;
>> +void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
>> +{
>> +	bus->domain_nr = pci_get_domain_nr(parent);
>>  }
>>  #endif
> 
> This code is superseded by the last patches I sent to move the domain
> assignment to PCI core code.
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/301220.html

OK, I will update it based the latest one.

> 
> Lorenzo
> 
> 
> .
> 


-- 
Thanks!
Yijing
