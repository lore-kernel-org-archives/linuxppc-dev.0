Message-ID: <3BB98292.FCC8DDF7@esd-electronics.com>
Date: Tue, 02 Oct 2001 11:02:10 +0200
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: simple access to mem mapped peripheral
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I need a "very simple" way to access a mem mapped peripheral. The device
is mem mapped at 0xf0200000.
I was trying /dev/mem but this dev only accesses my physical memory
chips.

My target is a ppc405gp running recent kernel 2.4.10.

Any idea ?

Matthias

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
