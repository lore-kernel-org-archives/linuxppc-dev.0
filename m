Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 29B902C007C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Feb 2014 11:53:35 +1100 (EST)
Message-ID: <52FEB98D.4070001@huawei.com>
Date: Sat, 15 Feb 2014 08:49:17 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/6] PCI,
 acpiphp: Use list_for_each_entry() for bus traversal
References: <1392297243-61848-1-git-send-email-wangyijing@huawei.com>
 <2601738.3Ek05F9oo5@vostro.rjw.lan> <52FD7D3D.4030409@huawei.com>
 <2512180.zyEb2tzySd@vostro.rjw.lan>
In-Reply-To: <2512180.zyEb2tzySd@vostro.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
Cc: Russell King <linux@arm.linux.org.uk>, David Airlie <airlied@linux.ie>,
 linux-pcmcia@lists.infradead.org, Hanjun Guo <guohanjun@huawei.com>,
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> Does it conflict with anything currently in linux-next (the linux-next branch
>>> of linux-pm.git in particular)?
>>
>> Hi Rafael,
>>    I applied this to your linux-next branch successfully . No conflicts found.
> 
> Good. :-)
> 
> Please feel free to add my ACK to it.

Thanks very much!
