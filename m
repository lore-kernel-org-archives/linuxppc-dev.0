From: vunnam.rao@wipro.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: QMC
Date: Wed, 7 Jul 2004 12:33:20 +0530
Message-ID: <D3C8905000DE1C42BC5378A14C7FD15F01234597@hyd-lax-msg.wipro.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Gurus,

We have developed a QMC driver for MPC860P and the TX is working fine.
We are getting interrupts for Tx, But, the RX we are not yet all getting
any interrupt.

I am using the functionality for providing GCI(2 bits/D-channel, and a
total of 8 such channels) support through SCC3 port of the MPC860P. The
configuration of TSA Ram, and QMC Global/Specific parameters have been
correctly done. Though I receive TX interrupts, I am not able to receive
any RX Interrupts. This is strange because I can even see incoming
physical data on the Rx port through a Logic Analyzer.

I do not get any data in the receive buffers at all. The QMC
initialization has been done in line with the example code provided from
Motorola at:
https://e-www.motorola.com/webapp/Download?colCode=MPC860COD05&prodCode=
MPC860&nodeId=03C1TR046708718657&appType=license&location=psp

I tried with loopback, but to no success.
The basic doubt here is do we need any microcode for QMC on MPC860P.

Thanks in advance!!!

Best regards,

Kondala

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
