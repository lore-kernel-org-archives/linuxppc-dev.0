Message-ID: <3C14B86D.726DBDE6@allot.com>
Date: Mon, 10 Dec 2001 15:28:13 +0200
From: Felix Radensky <felix@allot.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: ppc405_enet problems
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm trying to run the latest linuxppc_2_4_devel kernel on
our custom 405GP based board. I get kernel panic when an
attempt is made to probe for ethernet controller phy:

Kernel panic: eth0: PHY id 0xfbc85c20 is not supported!

The phy is National Semiconductor DP83846AVHG.
It works fine with Monta Vista HHL 2.0 kernel.

What you think could be the problem ?

TIA.

Felix.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
