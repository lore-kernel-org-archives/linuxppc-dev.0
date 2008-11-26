Return-Path: <leon.woestenberg@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id 00280DDDE0
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 02:25:24 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so121247qwb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 07:25:23 -0800 (PST)
Message-ID: <c384c5ea0811260725x3476fa43o9950123948e99acb@mail.gmail.com>
Date: Wed, 26 Nov 2008 16:25:23 +0100
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: AMCC PPC460EX Canyonlands does not see PCIe end point with only
	non-prefetchable memory (both 2.6.27.7 and -next)
In-Reply-To: <c384c5ea0811260632n24e8b536v9a4a16833644976c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c384c5ea0811260632n24e8b536v9a4a16833644976c@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I enabled more DEBUG output, the online files have been updated. Snippets:

The detected end point boot:

pci 0001:80:00.0: scanning behind bridge, config bf8180, pass 0
PCI: Scanning bus 0001:81
pci 0001:81:00.0: found [1a0b:5331] class 00ff00 header type 00
pci 0001:81:00.0: reg 10 64bit mmio: [0xb8000000-0xb8ffffff]
pci 0001:81:00.0: reg 18 32bit mmio: [0xb9000000-0xb903ffff]
pci 0001:81:00.0: calling pcibios_fixup_resources+0x0/0xec
pci 0001:81:00.0: calling fixup_ppc4xx_pci_bridge+0x0/0x154
pci 0001:81:00.0: disabling ASPM on pre-1.1 PCIe device.  You can
enable it with 'pcie_aspm=force'
PCI: Fixups for bus 0001:81

The non-detected end point boot:

pci 0001:80:00.0: scanning behind bridge, config bf8180, pass 0
PCI: Scanning bus 0001:81
PCI: Fixups for bus 0001:81

Regards,
-- 
Leon
