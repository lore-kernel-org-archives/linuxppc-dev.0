Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x22f.google.com (mail-ie0-x22f.google.com
 [IPv6:2607:f8b0:4001:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 540A91A0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 09:50:03 +1000 (AEST)
Received: by iesa3 with SMTP id a3so121386909ies.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2015 16:50:01 -0700 (PDT)
Date: Mon, 1 Jun 2015 18:49:58 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH V7 06/10] powerpc/eeh: Create PE for VFs
Message-ID: <20150601234958.GG3631@google.com>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-7-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432032612-21701-7-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 19, 2015 at 06:50:08PM +0800, Wei Yang wrote:
> Current EEH recovery code works with the assumption: the PE has primary
> bus. Unfortunately, that's not true to VF PEs, which generally contains

"Primary bus" normally means the bus on the upstream side of a PCI bridge.
But a PE is not a bridge, so I don't know what it means here.

s/not true to VF PEs/not true for VF PEs/

> one or multiple VFs (for VF group case). The patch creates PEs for VFs
> at PCI final fixup time. Those PEs for VFs are indentified with newly

s/indentified/identified/

> introduced flag EEH_PE_VF so that we handle them differently during
> EEH recovery.
