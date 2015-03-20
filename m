Return-Path: <bhelgaas@google.com>
Received: from mail-qc0-x233.google.com (mail-qc0-x233.google.com
 [IPv6:2607:f8b0:400d:c01::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C66EC1A2A87
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 01:34:28 +1100 (AEDT)
Received: by qcay5 with SMTP id y5so4242367qca.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 07:34:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150320054327.GA8119@shangw>
References: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150320054327.GA8119@shangw>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 20 Mar 2015 09:34:04 -0500
Message-ID: <CAErSpo6zTLyDK+aaHK6+uwfs579Qq1vbXDx4rb9L4uNq=24dVA@mail.gmail.com>
Subject: Re: [PATCH V14 00/21] Enable SRIOV on Power8
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 20, 2015 at 12:43 AM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> On Fri, Mar 20, 2015 at 11:06:16AM +0800, Wei Yang wrote:
>
> [snip]
>
>>---
>>v14:
>>   * call ppc_md.pcibios_fixup_sriov() in pcibios_add_device
>>   * add more explanation in change log
>>   * Following patches have been reordered to the beginning.
>>     "EEH refactor to use pci_dn":
>>     8ec20d6 powerpc/powernv: Use pci_dn, not device_node, in PCI config accessor
>>     a3460fc powerpc/pci: Refactor pci_dn
>>     These two patches will be modified to merge with other patches which are
>>     under discussion/review in ppc mail list. Some changes may also be made in
>>     other patches, which I didn't include them in this series, so that the
>>     auto build robot could work on this.
>
> The comment here isn't precise enough and not the things I suggested before.
> Those 2 patches have been split into 3 patches (A/B/C). Some other EEH
> cleanup/refactor patches depends on A/B and those patches would be merged
> before your SRIOV patches to PowerPC tree. C, which I already sent to you,
> need to be integrated to your patchset right after the following one:
>
> powerpc/pci: Don't unset PCI resources for VFs
>
> I guess you can move the patches around after checking if Bjorn has further
> concerns/comments.

I think we need to move forward on this soon so it has at least a
little time in -next.  And it sounds like I cannot merge this v14
as-is because it doesn't include these additional EEH cleanup/refactor
patches?  (If they are only cleanup and refactoring, I don't
understand why they would be required, but I haven't seen them, so I'm
taking your word for it.)

So I guess I'm waiting for v15.  Don't wait for my comments on v14.
Ideally I'd also like an ack from a powerpc maintainer.  This has so
much powerpc impact that I'm not comfortable stuffing this in without
their OK.

Bjorn
