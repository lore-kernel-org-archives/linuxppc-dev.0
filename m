Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x234.google.com (mail-ie0-x234.google.com
 [IPv6:2607:f8b0:4001:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5FFF32C031E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 09:42:48 +1100 (EST)
Received: by mail-ie0-f180.google.com with SMTP id tp5so9415929ieb.25
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 14:42:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1386647973.32037.57.camel@pasglop>
References: <1386244373-35796-1-git-send-email-wangyijing@huawei.com>
 <20131210000154.GE4699@google.com> <1386647973.32037.57.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 10 Dec 2013 10:28:01 -0700
Message-ID: <CAErSpo67ZB_GUrKpLbkfZs4qLe3S0eYy=oLTKg9=MSxZL2h+yw@mail.gmail.com>
Subject: Re: [PATCH 1/9] PCI: Use dev_is_pci() to check whether it is pci
 device
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 linux-parisc@vger.kernel.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linux-alpha@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 sparclinux@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
 Yijing Wang <wangyijing@huawei.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 9, 2013 at 8:59 PM, Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:
> On Mon, 2013-12-09 at 17:01 -0700, Bjorn Helgaas wrote:
>> [+cc arch lists]
>>
>> On Thu, Dec 05, 2013 at 07:52:53PM +0800, Yijing Wang wrote:
>> > Use dev_is_pci() instead of directly compare
>> > pci_bus_type to check whether it is pci device.
>> >
>> > Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>>
>> I applied all these to my pci/yijing-dev_is_pci branch for v3.14, thanks!
>>
>> Browse them here: http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/yijing-dev_is_pci
>
> Ah ok. I also have the powerpc one in powerpc -next, no biggie though

I'll drop the powerpc one.
