Subject: IO_BASE woes.
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <OF6A7540D3.FD212873-ON85256B19.0067E145@raleigh.ibm.com >
From: "Ralph Blach" <rcblach@us.ibm.com>
Date: Wed, 5 Dec 2001 13:59:38 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am having IO base woes on the 405xx based  power pc platform.

Heres the problem.

IO_base is meant to refernece the pci io_base, but now I have ISA based
chips attached to the EBC bus and an PCMCIA adapter connected
to EBC bus.

Along with the PCI, this spells a lot of rewrite of code.

The concept of an IO_base seems a little dated.

Chip


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
