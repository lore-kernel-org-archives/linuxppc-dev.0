Return-Path: <bhelgaas@google.com>
Received: from mail-ig0-x236.google.com (mail-ig0-x236.google.com
 [IPv6:2607:f8b0:4001:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C2021A0325
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 08:20:50 +1100 (AEDT)
Received: by igcqo1 with SMTP id qo1so2476544igc.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:20:48 -0700 (PDT)
Date: Fri, 20 Mar 2015 16:20:45 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V14 00/21] Enable SRIOV on Power8
Message-ID: <20150320212045.GL26935@google.com>
References: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 20, 2015 at 11:06:16AM +0800, Wei Yang wrote:
> This patchset enables the SRIOV on POWER8.
> 
> The general idea is put each VF into one individual PE and allocate required
> resources like MMIO/DMA/MSI. The major difficulty comes from the MMIO
> allocation and adjustment for PF's IOV BAR.
> 
> On P8, we use M64BT to cover a PF's IOV BAR, which could make an individual VF
> sit in its own PE. This gives more flexiblity, while at the mean time it
> brings on some restrictions on the PF's IOV BAR size and alignment.

For patches 03-12 (the "PCI: " ones):

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

It's fine if you want to take all these via the powerpc tree.  I don't see
much if anything in my queue that will conflict with them.

Bjorn
