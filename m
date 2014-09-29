Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (unknown [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3FEE61A17FC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Sep 2014 20:13:52 +1000 (EST)
Message-ID: <5429308A.7030201@huawei.com>
Date: Mon, 29 Sep 2014 18:12:26 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Liviu Dudau <liviu@dudau.co.uk>
Subject: Re: [PATCH v2 00/22] Use MSI chip framework to configure MSI/MSI-X
 in all platforms
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <20140925074235.GN12423@ulmo> <20140925144855.GB31157@bart.dudau.co.uk>
 <20140925164937.GB30382@ulmo> <5424E09F.50701@huawei.com>
 <20140926085030.GE31157@bart.dudau.co.uk> <54276F6C.5010705@huawei.com>
 <20140928112144.GA4671@bart.dudau.co.uk> <5428B971.50101@huawei.com>
 <20140929092600.GA15854@bart.dudau.co.uk>
In-Reply-To: <20140929092600.GA15854@bart.dudau.co.uk>
Content-Type: text/plain; charset="UTF-8"
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 Thierry Reding <thierry.reding@gmail.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>,
 xen-devel@lists.xenproject.org, arnab.basu@freescale.com,
 Arnd Bergmann <arnd@arndb.de>, Konrad
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

>>> Not necessarily. What I have in mind is something like this:
>>
>> This is a good idea, what I'm worried is this series is already large, so I think we need to post
>> another series to do it.
> 
> I wasn't asking to do it here, I was just offering a suggestion (and sharing some experience) when
> it comes to handling msi chip in an arch independent way.

It's a good suggestion, thanks! :)

> 
>>
>>
