Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6ABC8DDDED
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Dec 2008 10:00:41 +1100 (EST)
Subject: RE: PCI Resource allocation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Flores, Raul" <raul.flores@lmco.com>
In-Reply-To: <28CF047BB51A9C40A89E308370E2DA1117A4AB34@emss07m13.us.lmco.com>
References: <cbaa36330812041036u751ea939qc0aea60002655d07@mail.gmail.com>
	<1228431244.10722.4.camel@pasglop>
	<28CF047BB51A9C40A89E308370E2DA1117A4AB34@emss07m13.us.lmco.com>
Content-Type: text/plain
Date: Mon, 08 Dec 2008 10:00:30 +1100
Message-Id: <1228690830.7101.25.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Deepak Pandian <peerlessdeepaks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-12-04 at 18:12 -0600, Flores, Raul wrote:
> A bit off topic, but since the subject is pci resource allocation:
> 
> As entered here:
> http://bugs.gentoo.org/show_bug.cgi?id=249832
> 
> the 2.6.24-gentoo-r3 kernel; iomem tree for my video display works, but
> has not worked in the following kernels:
> 2.6.26-gentoo-r2
> 2.6.27-gentoo-r2
> 2.6.28-rc4 (perfmon2 git)
> 
> Using g5_defconfig on an iMac G5 iSight PowerMac 12,1 ppc64 (cross 32
> userspace) PPC970FX
> 
> Had to hack to arch/powerpc/kernel/pci-common.c in alloc_resource() so
> that I could run the 2.6.28 kernel with perfmon2.

That's strange... looks like something fishy with the PCI-E root
complex, can you enable DEBUG in pci-common.c and pci_64.c and send me
the resulting dmesg output ?

Cheers,
Ben.
