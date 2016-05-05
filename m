Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r150m1D2jzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 05:42:46 +1000 (AEST)
Date: Thu, 5 May 2016 14:42:35 -0500
From: Rob Herring <robh@kernel.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org,
 mpe@ellerman.id.au, aik@ozlabs.ru, bhelgaas@google.com,
 robherring2@gmail.com, dja@axtens.net, alistair@popple.id.au
Subject: Re: [PATCH v9 21/22] drivers/of: Export of_detach_node()
Message-ID: <20160505194235.GA13790@rob-hp-laptop>
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1462281773-26438-22-git-send-email-gwshan@linux.vnet.ibm.com>
 <20160504133603.GA30081@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160504133603.GA30081@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 04, 2016 at 11:36:03PM +1000, Gavin Shan wrote:
> On Tue, May 03, 2016 at 11:22:52PM +1000, Gavin Shan wrote:
> >This exports of_detach_node() for PowerPC PowerNV PCI hotplug
> >driver. No functional changes introduced.
> >
> >Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> 
> Rob, I'm not sure it's late to cache the 4.7 merge window.
> Also, I was told this series is needed by new CAPI driver which
> is being developed. The developers hope to push the new CAPI driver
> in 4.8 merge window (perhaps) or linux-next before 4.8 merge window
> is opened. It means the new CAPI driver depends on this series which
> has to be pushed to linux-next before 4.8 merge window.
> 
> If it's fine, could you please merge 16 to 21? With them merged to
> 4.7, the left patches won't depend on FDT changes. Thanks in advance
> for your help.

I've applied the 6 patches.

Rob
