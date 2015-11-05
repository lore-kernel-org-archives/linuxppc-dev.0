Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0110.outbound.protection.outlook.com [65.55.169.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBEB61A0CFE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 10:13:03 +1100 (AEDT)
Message-ID: <1446765154.12676.132.camel@freescale.com>
Subject: Re: powerpc/fsl-pci: Unify pci/pcie initialization code
From: Scott Wood <scottwood@freescale.com>
To: Daniel Walker <danielwa@cisco.com>
CC: Jia Hongtao <B38951@freescale.com>, Kumar Gala
 <galak@kernel.crashing.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>, "David
 Beazley (dbeazley)" <dbeazley@cisco.com>, "xe-kernel@external.cisco.com"
 <xe-kernel@external.cisco.com>
Date: Thu, 5 Nov 2015 17:12:34 -0600
In-Reply-To: <563BA46C.8000202@cisco.com>
References: <563BA46C.8000202@cisco.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-11-05 at 10:48 -0800, Daniel Walker wrote:
> Hi,
> 
> 905e75c46dba5f3061049277e4eb7110beedba43:arch/powerpc/platforms/85xx/mpc85xx_ads.c
> 
> 
> This commit seems to cause problems with PCI devices doing DMA, just 
> with mpc85xx ads. If you do the "fsl_add_bridge()" after you setup the 
> ppc_md.pci_exclude_device to mpc85xx_exclude_device, then the 
> early_read_config_word() calls in 
> arch/powerpc/sysdev/fsl_pci.c:setup_pci_cmd() are like no-ops.
> 
> This issue was found by David Beazley (on the CC), he can respond to 
> more detailed questions on it. The fix he came up with was to remove the 
> "pci_exclude_device".
> 
> Daniel

OK, please send a patch.

-Scott
