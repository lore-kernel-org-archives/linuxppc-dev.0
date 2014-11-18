Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3AF0C1A0745
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 23:43:01 +1100 (AEDT)
Message-ID: <546B3E7D.4030800@huawei.com>
Date: Tue, 18 Nov 2014 20:41:33 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 07/16] PCI: Separate pci_host_bridge creation out
 of pci_create_root_bus()
References: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
 <1936415.emTbbPeHqx@wuerfel> <546B3124.7070206@huawei.com>
 <2911754.xsk2IUfQFO@wuerfel>
In-Reply-To: <2911754.xsk2IUfQFO@wuerfel>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Liviu Dudau <liviu@dudau.co.uk>, Tony Luck <tony.luck@intel.com>, Russell
 King <linux@arm.linux.org.uk>, linux-pci@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
 Thierry Reding <thierry.reding@gmail.com>, Suravee.Suthikulpanit@amd.com,
 Bjorn Helgaas <bhelgaas@google.com>, linux-ia64@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Wuyun <wuyun.wu@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>> We need, some platforms pass NULL pointer as host bridge parent.
>>>
>>> But those don't have to use the new pci_create_host_bridge() function,
>>> right?
>>
>> As I mentioned in another reply, I hope all pci host drivers could use
>> pci_create_host_bridge(), keep different PCI scan interfaces in PCI core
>> make things become complex.
> 
> Doing this for all platforms that have PCI support would be a lot of
> work though, I think it's better to focus on having a the best interface
> for the majority of users.

Yes.

> 
> 	Arnd
> 
> .
> 


-- 
Thanks!
Yijing
