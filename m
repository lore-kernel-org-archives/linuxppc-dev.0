Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C59EB31.3FE82EE1@carts.com>
Date: Thu, 31 Jan 2002 17:11:14 -0800
From: Kevin Fry <kevin@carts.com>
MIME-Version: 1.0
To: linuxppc emb3dd3d list <linuxppc-embedded@lists.linuxppc.org>
Subject: 8260 + L2 Cache
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all, a few questions if I may..

We have a custom board with an MPC8260 and 1MB of L2
cache. The cache is controlled (flushed, invalidated, inhibited,
and locked) by 4 signals which are tied to GPIOs on the 8260.
We are booting with PPCBoot 1.1.2 and are using version 2.4.17
of the Linux kernel.

At boot time the L2 inhibit signal is asserted and remains so
until we toggle a bit in the Port D register. Doing so manually
results in Linux crashing (no big surprise). So the question is:
where in Linux should we be enabling the cache? At the same
time the L1 cache is enabled? Or should it be done before
Linux boots? I would think it should be done in Linux since that
is where the data cache is turned on, but I could be wrong.

Any help is greatly appreciated.

Thanks!
Kevin Fry


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
