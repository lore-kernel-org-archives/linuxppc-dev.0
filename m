Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Donald MacArthur" <dmacarth@ufl.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: SCC3 UART for MPC850
Date: Mon, 3 Mar 2003 08:52:41 -0500
Message-ID: <NDBBIHDFKLJKGJJGMFJOIEANCHAA.dmacarth@ufl.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am currently working with an embedded planet LICCE MPC850 Credit card
board with the associated MPC860 Timesys Linux Kernel.  I would like to use
as many SCC and SMC channels for UARTs as possible.  I have successfully
enabled SMC1, SMC2, and SCC2 for UART but SCC3 does not work.  Normally for
the UART channels the TX lines go high when the kernel boots but the SCC3 Tx
channel does not.  Does anyone know of modifications required for the kernel
to get SCC3 to work as a UART or were possible conflicts might arise?

Thank You
Don MacArthur
dmacarth@ufl.edu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
