Return-Path: <yhlu.kernel@gmail.com>
Received: from mail-vk0-x241.google.com (mail-vk0-x241.google.com
 [IPv6:2607:f8b0:400c:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQgCC3xHbzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 08:36:39 +1000 (AEST)
Received: by mail-vk0-x241.google.com with SMTP id a126so8633067vkb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jun 2016 15:36:39 -0700 (PDT)
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <CAE9FiQWw0pUB=1iDrX_1qyMFAUGQidSaV7CPc0aNb2CzPB-fZw@mail.gmail.com>
References: <20160604000642.28162-1-yinghai@kernel.org>
 <20160604000642.28162-2-yinghai@kernel.org>
 <20160608210322.GA4248@localhost>
 <CAE9FiQXPmG6UYYGHG52_i8vaBJ5yPm6Z4Zfx_BhQxVhyWC5fnw@mail.gmail.com>
 <CAE9FiQWw0pUB=1iDrX_1qyMFAUGQidSaV7CPc0aNb2CzPB-fZw@mail.gmail.com>
From: Yinghai Lu <yinghai@kernel.org>
Date: Thu, 9 Jun 2016 15:36:35 -0700
Message-ID: <CAE9FiQUNZ9xShfCHFvKobOJQ4zBfOrq_s=uYQAcR+YguigNjrQ@mail.gmail.com>
Subject: Re: [PATCH v12 01/15] PCI: Let pci_mmap_page_range() take extra
 resource pointer
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linux-cris-kernel@axis.com,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 linux-am33-list@redhat.com,
 linux-parisc@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-sh@vger.kernel.org,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 8, 2016 at 5:00 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Jun 8, 2016 at 3:35 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>
>> At the same time, can you kill __pci_mmap_set_pgprot() for powerpc.
>
> Can you please put your two patches and this attached one into to pci/next?
>
> Then I could send updated PCI: Let pci_mmap_page_range() take resource address.

Thanks for putting those patches in pci/resource branch.

I just re post updated for second patch.

[v12.update2,02/15] PCI: Let pci_mmap_page_range() take resource address
http://patchwork.ozlabs.org/patch/633399/

And the [v12 01/15] is not needed anymore.

patch3 to patch15 should still can be applied to pci/resource without problem.

Thanks

Yinghai
