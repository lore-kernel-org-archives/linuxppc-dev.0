Message-ID: <3AEE0E5C.955341B3@dominetsystems.com>
Date: Mon, 30 Apr 2001 18:16:12 -0700
From: Denton Gentry <denny@dominetsystems.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: 405gp PCI?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  I'm attempting to bring up a PCI ethernet card in a 405GP
Walnut platform. The PCI device signals a Master Abort, and
from probing the PCI bus it is clear that it does: no target
asserts DEVSEL in response to its DMA.
  My first thought was of a simple byte ordering problem. I
tried reversing the byte order of the addresses handed to the
PCI device. It gets no further than it did before: no target
responds with DEVSEL, so it times out and asserts a master abort.

  I've printed out and checked the I/O addresses, and haven't
made any progress. So I thought I'd step back and validate some
assumptions. I'm using a kernel compiled from the fsmlabs source
as of last Tuesday (I have not pulled over new code since the
boot reorganization was done, I want to get this working first).

  Is the PCI bus in the 405gp known to work in recent kernels?

  Also, though I'm certain that this problem is not caused by
stale data, one of the next things I'll need to tackle is cache
coherency. Can anyone point me to a driver which properly marks
memory as non-cacheable, to use as an example?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
