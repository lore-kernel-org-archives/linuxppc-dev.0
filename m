From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: "PPC_LINUX" <linuxppc-embedded@lists.linuxppc.org>
Subject: pci on ppc
Date: Wed, 30 Jun 2004 12:33:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200406301233.24676.Schramel.Linux@go.bartec.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

my kernel does not boot with the kernel option "CONFIG_PCI". (System MPC8270 (PQ2FADS), 2.4.25 denx kernel, eldk 3.0).
Without the pci option it can boot without problems.
UBoot supports my pci. It shows the bridge and the cards i put in.
What i have to attend in the kernel for the 82xx?

Where the function "m8260_setup_arch()" (m8260_setup.c) is called ?? With the pci option the kernel does not call this function.

Thanks a lot
Marco


---------
Marco Schramel
R&D
Bartec GmbH
Schulstr. 30
94239 Gotteszell, Germany
www.bartec.de
Marco.Schramel@go.bartec.de
Phone:  +49 (0)9929/301332
Fax:    +49 (0)9929/301112


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
