Date: Wed, 31 May 2000 09:02:15 -0400
From: Josh Huber <huberj@wpi.edu>
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Lite-On ethernet controller
Message-ID: <20000531090215.A652@mclinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have what appears to be a Lite-On ethernet controller, which is supported
by the tulip driver. What it really is, is a Asante FriendlyNET card. I had
heard that the card works in 2.2.14+, but I'm having trouble getting it to
work in later kernels (devel).

Because of the network driver interface change, I can't try out the newest
tulip driver in 2.4pre.  Does anyone know of forward-ported tulip drivers?

The particular error I'm seeing only happens with moderate load -- pings and
other light traffic work 100%.

Error information:
NETDEV WATCHDOG: eth1: transmit timed out
Transmit timed out, status e4660000, CSR12 000050ca, resetting...

Device information:
tulip driver output:
eth1: Lite-On PNIC-II rev 37 at 0x1c00, 00:00:94:C5:EF:FF, IRQ 30.
lspci -vv output attached because it's too wide.

Any ideas?

Josh

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
