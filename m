Subject: MVista: CDK 1.2 2.2.14 for SBS-K2 (750) Module Support
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF205CEC3C.F52A4B97-ON85256AA2.0049AD5B@raleigh.ibm.com>
From: "John F Davis" <johndavi@us.ibm.com>
Date: Wed, 8 Aug 2001 09:10:22 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello

We are trying to build a kernel with loadable modules support using a stock
mvista CDK 1.2 toolset.  The
error is that many symbols are not resolved correctly.  If I build without
module
support the kernel builds fine.

For what its worth, we noticed that pci_io_base (one of the undefined
symbols) was defined in the powermac tree.

Lastly, does Mvista release different releases or patches for the same
kernel?  ie., We build 2.2.14 kernels
with module support on other machines here in the lab.  However, building
this kernel on a newly installed machine fails.

John


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
