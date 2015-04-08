Return-Path: <yhlu.kernel@gmail.com>
Received: from mail-ig0-x234.google.com (mail-ig0-x234.google.com
 [IPv6:2607:f8b0:4001:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38CEF1A0143
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 08:38:44 +1000 (AEST)
Received: by iget9 with SMTP id t9so38245306ige.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2015 15:38:42 -0700 (PDT)
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <1428480074.18187.8.camel@kernel.crashing.org>
References: <1428452669-24824-1-git-send-email-yinghai@kernel.org>
 <1428464944.4947.69.camel@kernel.crashing.org>
 <CAE9FiQVwKpUB2Qh+_sqO363BfZz2ueoUxe=0ZYM1SE=ONquvdA@mail.gmail.com>
 <1428480074.18187.8.camel@kernel.crashing.org>
Date: Wed, 8 Apr 2015 15:38:42 -0700
Message-ID: <CAE9FiQU=SHqopf_eZWBufD5-LNo_Lv_SH=iptOhFUuPGLgcxAw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in
 of parsing
From: Yinghai Lu <yinghai@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Yijing Wang <wangyijing@huawei.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 8, 2015 at 1:01 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> Use a different flag to indicate the BAR policy or temporarily tweak a
> local copy of the resource flag during BAR assignment or whatever you
> prefer to fix the original problem but do *not* change the Linux overall
> view of that BAR to lie about prefetchability.

ok, will give it a try.

        Yinghai
