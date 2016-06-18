Return-Path: <yhlu.kernel@gmail.com>
Received: from mail-vk0-x236.google.com (mail-vk0-x236.google.com
 [IPv6:2607:f8b0:400c:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rWgy36RK8zDqmH
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jun 2016 12:27:39 +1000 (AEST)
Received: by mail-vk0-x236.google.com with SMTP id d185so137744974vkg.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 19:27:39 -0700 (PDT)
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <20160617195237.GA10416@localhost>
References: <20160609222552.6938-1-yinghai@kernel.org>
 <20160617021555.GA21125@localhost>
 <CAE9FiQVMxuo16MArLXjT8oaSGMce1G=evaWqeOaW-WeT_ju6Mw@mail.gmail.com>
 <20160617195237.GA10416@localhost>
From: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 17 Jun 2016 19:27:36 -0700
Message-ID: <CAE9FiQVF5eZzXHqe=VLW954LOSdZmD5eMT5w6nTwd-KpX1LX0w@mail.gmail.com>
Subject: Re: [PATCH v12.update2 02/15] PCI: Let pci_mmap_page_range() take
 resource address
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
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

On Fri, Jun 17, 2016 at 12:52 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> and respin the whole patchset today.
>
> I added your acks and pushed the result to pci/resource.  I'll also
> post these formally on the list so they're easier to find.

Please review patchset v13 that is against your new pci/resource branch.

Thanks

Yinghai
