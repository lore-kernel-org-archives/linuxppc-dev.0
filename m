Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0184.outbound.protection.outlook.com [207.46.163.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8EE692C0085
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jan 2014 09:37:32 +1100 (EST)
Message-ID: <1388788641.11795.76.camel@snotra.buserror.net>
Subject: Re: [PATCH 01/12][v3] pci: fsl: derive the common PCI driver to
 drivers/pci/host
From: Scott Wood <scottwood@freescale.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 3 Jan 2014 16:37:21 -0600
In-Reply-To: <20131125230116.GA3819@google.com>
References: <1382524894-15164-1-git-send-email-Minghuan.Lian@freescale.com>
 <20131125230116.GA3819@google.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Zang Roy-R61911 <r61911@freescale.com>, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-11-25 at 16:01 -0700, Bjorn Helgaas wrote:
> On Wed, Oct 23, 2013 at 06:41:23PM +0800, Minghuan Lian wrote:
> > The Freescale's Layerscape series processors will use ARM cores.
> > The LS1's PCIe controllers is the same as T4240's. So it's better
> > the PCIe controller driver can support PowerPC and ARM
> > simultaneously. This patch is for this purpose. It derives
> > the common functions from arch/powerpc/sysdev/fsl_pci.c to
> > drivers/pci/host/pci-fsl-common.c and leaves the architecture
> > specific functions which should be implemented in arch related files.
> > 
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> 
> It doesn't look like we have a consensus on how to proceed here, so I'm
> ignoring this series for now.  Let me know if there really *is* agreement,
> or if there's some subset of this work that everybody can agree on.  It'd
> be good to make forward progress, even if it's not completely perfect yet.

I'd like to see what this would look like with actual ARM support,
rather than just some theoretical attempts to make it less PPC-dependent
that involve copying PPC stuff that may or may not work well with what
ARM code will expect.

When I replied to Kumar's comment saying that this seemed like a
reasonable interim approach, that was before I saw how much was copied
from places other than fsl_pci files.

-Scott
