From: =?iso-8859-1?Q?G=E9rard_Gu=E9vel?= <gguevel@interfaceconcept.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: 8260 FCC enet driver problem
Date: Tue, 30 Sep 2003 17:20:35 +0200
Message-ID: <000001c38766$68b14d90$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I use a 2.4.18 Linux kernel on my custom 8260 board with 3 FCC ports.
These 3 ports work fine at 100Mbs half or full duplex.

I connect 2 boards on the first port via a 10Mbs hub.
The ports auto-negotiate and fall into 10Mbs half duplex mode.

A board sends short udp messages as fast as possible to the other one
and vice-versa.

I get the following message and the two ports are locked forever :

> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: transmit timed out.
>  Ring data dump: cur_tx c0164220 (full) cur_rx c01641e8.
>  Tx @base c0164208 :
> 9c00 0048 018d1ee2
> 9c00 0048 018d15e2
> 9c00 0048 018d1ae2

The PHY devices seem to be well configured.

Does anyone know what are the conditions to fall into this trap ?
Is it a PHY problem, a driver configuration problem or something else ?
Why does the problem not disappear when the traffic is interrupted ?
Only a board reset can reactivate the ports.

Thank you for your help.

Gérard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
