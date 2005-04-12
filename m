Return-Path: <Schramel.Linux@go.bartec.de>
Received: from mail.bartec.de (mail.bartec.de [217.5.168.170])
	by ozlabs.org (Postfix) with SMTP id 5381B67A2E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 20:17:16 +1000 (EST)
From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: "PPC_LINUX" <linuxppc-embedded@ozlabs.org>
Date: Tue, 12 Apr 2005 12:14:28 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200504121214.28076.Schramel.Linux@go.bartec.de>
Subject: IDE and PCI
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

we runs a 2.4.25 on a custum board (MPC8270). We use compact flash over UPM. All runs fine.
But if i config in the pci bus the i/o accesses on compact flash will fail. The kernel booting fails and it hangs up.
At the same time i can read out the cf registers with bdi. 
It crashes on the first INB() call in ide_probe.c.   "stat = hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);". Without pci it works fine.

Any ideas?

Thanks in advance
Marco
