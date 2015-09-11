Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 346B71A1F40
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2015 16:47:56 +1000 (AEST)
Received: from [192.168.1.106] (ppp-93-104-66-186.dynamic.mnet-online.de
 [93.104.66.186]) by smtp.strato.de (RZmta 37.12 DYNA|AUTH)
 with ESMTPSA id V010e8r8B5mphMt
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH
 bits, eq. 15360 bits RSA)) (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Fri, 11 Sep 2015 07:48:51 +0200 (CEST)
To: linuxppc-dev@lists.ozlabs.org
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [Nemo, Chitra, and Electra] Linux kernel 4.3 testing
Message-ID: <55F26B43.7080906@xenosoft.de>
Date: Fri, 11 Sep 2015 07:48:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

We compiled some kernels from the Linux git for our motherboards with 
P.A. Semi PA6T-1682M microprocessors for testing.

Downloads:

http://www.xenosoft.de/vmlinux-4.3-alpha6-AMIGA_one_X1000.tar.bz2 (Build 
date: 07. September 2015)

http://www.xenosoft.de/vmlinux-4.3-alpha7-AMIGA_one_X1000.tar.bz2 (Build 
date: 09. September 2015)

Maybe someone would like to test these kernels.

Further information about motherboards with P.A. Semi PA6T-1682M 
microprocessors:

* Electra: First development/eval board. Funky USB on localbus, plenty
of PCI-e. Two GigE, one 10GigE XAUI. CompactFlash and IDE on localbus
too. Usually shipped with a PCI-e SATA card and a USB card.

* Chitra: Second edition dev/eval board. Moved SATA and USB on-board,
and removed some of the localbus hardware. Might have routed three
GigE out instead of 2.

* Athena: Never released board with a smaller package chip, there's
only a few of these around. It's similar to Chitra, and the silicon is 
the same.

* Nemo: Released as AmigaONE X1000. With co-processor: "Xena" 500 MHz 
XCore XS1-L2 124 SDS
and SB600 southbridge. AMD/ATI’s SB600 provides the following I/O features:

- PCIe x4 link to CPU
- SATA-II AHCI controller with 4 ports
- PATA (IDE) controller (single channel)
- multiple USB ports (5 OHCI and 1 EHCI host controllers. All ports are 
fully USB 1.1 and USB 2.0 compliant)
- UAA compatible HD Audio controller
- PCIe-PCI bridge supporting multiple PCI slots with 5V signalling support
- 8259 compatible interrupt controller
- Real Time Clock

CompactFlash and Xena on localbus.

Cheers,

Christian
