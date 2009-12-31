Return-Path: <lonsn2005@gmail.com>
Received: from mail-pz0-f172.google.com (mail-pz0-f172.google.com
	[209.85.222.172]) by ozlabs.org (Postfix) with ESMTP id 8C75A1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 31 Dec 2009 19:55:28 +1100 (EST)
Received: by pzk2 with SMTP id 2so8562651pzk.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 31 Dec 2009 00:55:26 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 31 Dec 2009 16:55:26 +0800
Message-ID: <6caf4b5a0912310055h54a6efa6ka1825f19a7f0c691@mail.gmail.com>
Subject: How to access PPC460EX SDRAM space from PCI/PCIe.
From: Lonsn <lonsn2005@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: sr@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi:
I'm now using canyonlands board with latest u-boot and linux kernel
from DENX git.
A PCIe card is plugged in the PCIeX4 slot. The PCIe card is a PCIe-pci
bridge(PI7C9X130) plus an Altera fpga.
The PCIe card act as a PCI master and send data to SDRAM of 460EX
space (total sdram 512MB, reserve 8M for PCI write data(0x1F800000)).
Now linux can identify this card, but CPU cann't receive any data from
PCIe and no PCIe interrupt.
I know about the PCI card works in 32bit mode and doesn't support
64bit address(No pci dual address cycle support).
Does the PCI card can access PPC460EX sdram space using just 32bit
physical address(0x1F800000)?

Best regards,
Lonsn
