Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Ppc Developers" <linuxppc-dev@lists.linuxppc.org>
Subject: PCI address translation design notes
Date: Mon, 5 Aug 2002 22:41:28 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFEEGBDKAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Are there notes regarding the host bridge initialization and the various
address translations? I have read the Documentation/pci.txt file and it
pertains to PCI device drivers.

Any information regarding the setup of:
Host to PCI bus I/O and Memory resource configuration
PCI bus to Host resource configuration
PCI device to device resource access

The basic problem is that the views between the buses does not have to be,
and in my case are not orthogonal.

I.e.
Host to PCI Memory
base = 0x48000000

PCI to Host Memory
base = 0x40000000

PCI device to device memory
base = 0x00000000

TIA


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
