Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0240.outbound.protection.outlook.com [207.46.163.240])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AC9A62C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 08:58:19 +1100 (EST)
Message-ID: <1389218288.25654.26.camel@snotra.buserror.net>
Subject: Re: [PATCH 02/12][v4] pci: fsl: add structure fsl_pci
From: Scott Wood <scottwood@freescale.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Date: Wed, 8 Jan 2014 15:58:08 -0600
In-Reply-To: <1389157323-3088-2-git-send-email-Minghuan.Lian@freescale.com>
References: <1389157323-3088-1-git-send-email-Minghuan.Lian@freescale.com>
 <1389157323-3088-2-git-send-email-Minghuan.Lian@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-01-08 at 13:01 +0800, Minghuan Lian wrote:
> PowerPC uses structure pci_controller to describe PCI controller,
> but ARM uses structure pci_sys_data. In order to support PowerPC
> and ARM simultaneously, the patch adds a structure fsl_pci that
> contains most of the members of the pci_controller and pci_sys_data.
> Meanwhile, it defines a interface fsl_arch_sys_to_pci() which should
> be implemented in architecture-specific PCI controller driver to
> convert pci_controller or pci_sys_data to fsl_pci.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
> change log:
> v4:
> Added indirect type macro
> v1-v3:
> Derived from http://patchwork.ozlabs.org/patch/278965/
> 
> Based on upstream master.
> Based on the discussion of RFC version here
> http://patchwork.ozlabs.org/patch/274487/
> 
>  include/linux/fsl/pci-common.h | 48 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

Same comments on this patchset as last time.

-Scott
