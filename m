Subject: Re: multiple separate pci bridges ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marcus Barrow <mbarrow@sangate.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1073423344.5358.160.camel@boat.sangate.com>
References: <1073423344.5358.160.camel@boat.sangate.com>
Content-Type: text/plain
Message-Id: <1073429964.773.16.camel@gaston>
Mime-Version: 1.0
Date: Wed, 07 Jan 2004 09:59:24 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>         Would you care to rethink those comments?
>
>         It seems unfair to call a chip shit, when you don't have
>         a manual for it and appear to lack any knowledge of it's
>         internals. Do the math for 3 GigE ports running line speed with
>         64 byte packets, and full bandwidth on 2 PCI busses...

It would still have been easy to have them "show up" as PCI devices
for the sake of proper discovery (and eventually mapping their control
registers as PCI devices), without impairing their ability to use
a fast path for DMA transfers.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
