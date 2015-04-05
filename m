Return-Path: <bhelgaas@google.com>
Received: from mail-qc0-x22e.google.com (mail-qc0-x22e.google.com
 [IPv6:2607:f8b0:400d:c01::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DD2B1A0AC8
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Apr 2015 13:25:26 +1000 (AEST)
Received: by qcrf4 with SMTP id f4so1868988qcr.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2015 20:25:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJyH==8OtkcU8_P4_47U6qe6FYqj-WUZ20_Y+iC_OF4_w@mail.gmail.com>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
 <1427857069-6789-2-git-send-email-yinghai@kernel.org>
 <20150403193234.GD10892@google.com>
 <20150403205201.GF10892@google.com>
 <CAE9FiQVqAEvoLDRZMcNFki0gLMQiyQd2VYivjAh1teRGeuNwBw@mail.gmail.com>
 <CAErSpo55rpO6SNeY57zZ8ah0PJ3eY+-L92vUJwYiRn4tCfLtJg@mail.gmail.com>
 <CAL_JsqJyH==8OtkcU8_P4_47U6qe6FYqj-WUZ20_Y+iC_OF4_w@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 4 Apr 2015 22:25:03 -0500
Message-ID: <CAErSpo4cw2MSPmrur_QFMwnH01qf0XMfBEAyZ2f+HrUOGEXyjw@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: Introduce pci_bus_addr_t
To: Rob Herring <robherring2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: David Ahern <david.ahern@oracle.com>, Russell King <linux@arm.linux.org.uk>,
 Sam Ravnborg <sam@ravnborg.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 Yinghai Lu <yinghai@kernel.org>, David Miller <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Apr 4, 2015 at 2:48 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Sat, Apr 4, 2015 at 7:46 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:

>> I think there's still an unresolved question about the OF parsing code.
>
> Got a pointer to what that is? I'll take a guess. Generally, we make
> the parsing code independent of the kernel addr sizes and use u64
> types. The DT sizes and kernel sizes are not always aligned. For
> example, an LPAE capable platform running a non-LPAE kernel build.

Yep: http://lkml.kernel.org/r/1427857069-6789-3-git-send-email-yinghai@kernel.org

Yinghai made a change to the sparc OF parsing code.  The question is
whether a similar change should be made to clones of that code (two
others in arch/sparc, one in arch/powerpc, and one in drivers/of).

Bjorn
