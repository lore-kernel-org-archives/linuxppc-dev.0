Message-ID: <00a101c0c2a9$264c2580$6c125acf@mrsl.com>
From: "Tim Moloney" <moloney@mrsl.com>
To: <linuxppc-dev@lists.linuxppc.org>,
	<yellowdog-devel@lists.yellowdoglinux.com>
Subject: Interrupt handling via OpenPIC
Date: Wed, 11 Apr 2001 13:00:55 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am writing a device driver for a custom PMC card, and I'm having
trouble with the interrupt service routine.

Although the PCI configuration block says that the board's interrupt
is 9, I am receiving interrupt 3.  I know that the OpenPIC is supposed
to remap the interrupts but I don't quite understand the process.
I've looked at the board's users manual and skimmed the Linux kernel
but I can't find a good example of what to do.

Can anyone provide pointers to documentation, example code, etc. that
shows how I can reconcile what the kernel thinks the interrupt is with
what in actually being generated?

Additional info:
I am developing on a Synergy Microsystems VSS4 board.  This is a
quad-G4 VME board that has the following:
  IBM MPIC-2 interrupt controller
  Motorola MPC106 Grackle PCI bridge/memory controller
  Symbios 53c885 Ethernet/SCSI controller
  Tundra Universe II PCI-VME64 bridge
  DEC/Intel 21554 PCI-PCI bridge

Thanks for any help.

Tim Moloney

ManTech Real-time Systems Laboratory
2015 Cattlemen Road
Sarasota, FL  34232
(941) 377-6775 x208


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
