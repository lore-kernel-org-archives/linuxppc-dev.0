Return-Path: <bhelgaas@google.com>
Received: from mail-ig0-x22b.google.com (mail-ig0-x22b.google.com
 [IPv6:2607:f8b0:4001:c05::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 786A02C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 11:12:59 +1100 (EST)
Received: by mail-ig0-f171.google.com with SMTP id c10so14619090igq.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jan 2014 16:12:54 -0800 (PST)
Date: Wed, 8 Jan 2014 17:12:52 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 02/12][v4] pci: fsl: add structure fsl_pci
Message-ID: <20140109001252.GA20070@google.com>
References: <1389157323-3088-1-git-send-email-Minghuan.Lian@freescale.com>
 <1389157323-3088-2-git-send-email-Minghuan.Lian@freescale.com>
 <1389218288.25654.26.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389218288.25654.26.camel@snotra.buserror.net>
Cc: linux-pci@vger.kernel.org, Minghuan Lian <Minghuan.Lian@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 08, 2014 at 03:58:08PM -0600, Scott Wood wrote:
> On Wed, 2014-01-08 at 13:01 +0800, Minghuan Lian wrote:
> > PowerPC uses structure pci_controller to describe PCI controller,
> > but ARM uses structure pci_sys_data. In order to support PowerPC
> > and ARM simultaneously, the patch adds a structure fsl_pci that
> > contains most of the members of the pci_controller and pci_sys_data.
> > Meanwhile, it defines a interface fsl_arch_sys_to_pci() which should
> > be implemented in architecture-specific PCI controller driver to
> > convert pci_controller or pci_sys_data to fsl_pci.
> > 
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> > ---
> > change log:
> > v4:
> > Added indirect type macro
> > v1-v3:
> > Derived from http://patchwork.ozlabs.org/patch/278965/
> > 
> > Based on upstream master.
> > Based on the discussion of RFC version here
> > http://patchwork.ozlabs.org/patch/274487/
> > 
> >  include/linux/fsl/pci-common.h | 48 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> 
> Same comments on this patchset as last time.

Minghuan, when you address Scott's comments, can you also add a
MAINTAINERS update?

Bjorn
