Return-Path: <johnny.hacking@gmail.com>
Received: from mail-yx0-f195.google.com (mail-yx0-f195.google.com
	[209.85.210.195])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 85EB5B70C0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 01:58:24 +1000 (EST)
Received: by yxe33 with SMTP id 33so7047281yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Jun 2009 08:58:22 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 29 Jun 2009 23:58:22 +0800
Message-ID: <cb9ecdfa0906290858x125b8149na037f33258c21426@mail.gmail.com>
Subject: PCI device support in Open Firmware (device tree syntax)
From: Johnny Hung <johnny.hacking@gmail.com>
To: linux-embedded@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	kernelnewbies@nl.linux.org, scottwood@freescale.com
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,
    I am working in customized Freescale MPC8313 board. There are two
PCI devices (Broadcom Switch) in PCI bus.
Each PCI device has its configuration space. It contains
vendor/product ID (RO)..., and important information, likes BARs
(Base Address), INT line and IRQ(RW). These resources (BAR, INT, IRQ)
is assigned from BIOS in x86 arch.
    My problem is how to assign PCI device resources in device tree. I
can't find exist dts file as an example. I have read the
http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf
file. It's described detailed about device tree
except PCI device. So, anyone give me a hint or sany tuff is appreciated.
   I think Linux Kernel parses device tree and get the PCI device
resources information then write into PCI configuration space.
So PCI device driver do pci_register_driver (get resource) and do
itself probe for PCI device. Is it right? CMIIAW

BRs, H. Johnny
