From: g.ramakrishna@exgate.tek.com
Message-ID: <301A812E6528D511A8F70008C71E578616CCC3@AP-BANG-M02>
To: linuxppc-dev@lists.linuxppc.org
Subject: PLX 9054 PCI  bridge driver 
Date: Sun, 18 Aug 2002 03:58:07 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

I am planning to write host bridge driver for PLX PCI 9054 bridge.
So, I have started reading PCI implementation in Linux.  While reading the
sources,
I could not clearly understand the significance and use of the following
macros and variables.

	_IO_BASE
	_ISA_MEM_BASE
	PCI_DRAM_OFFSET
	isa_io_base
	isa_mem_base
	pci_dram_offset

Can anyone help me in this regard.  Any kind of help is greatly appreciated.
Thank you in advance.
I had prior experience with Linux frame buffer drivers.

-RK

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
