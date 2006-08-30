Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 7B34167B52
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 02:30:59 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7cc604637892c0a00a5e3e38192494d7@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: PCIe enhanced configuration mechanism support on ppc arch
Date: Wed, 30 Aug 2006 11:30:49 -0500
To: Shawn Jin <shawnxjin@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri Aug 18 05:01:48 EST 2006, Shawn Jin wrote:
> I'm trying to find out if the current PCI subsystem supports the PCIe
> enhanced configuration mechanism, in particular, on the ppc/powerpc
> arch, which is basically a MMIO access with the address containing all
> bus, device, function, and offset info.

If what you are really trying to find is the 4k extended config space,
then there are some platforms that support that on some slots.

If you are trying to find the mmio address for your adapter, then the
answer is I am not aware of any PowerPC platforms that provide that,
although I am not familiar with the embedded processor platforms nor
the pci express Apple boxes.

> Could someone here give an authoritative answer? Or point me to
> somewhere I can look for it by myself, such as which file or directory
> in the kernel tree. I searched at arch/ppc/kernel,
> arch/powerpc/kernel, and drivers/pci but couldn't find an answer. :(

The config access support is in arch/powerpc/kernel/rtas_pci.c,
the setting of pci_ext_config_space is at arch/powerpc/kernel/pci_dn.c.

milton
