Message-ID: <B25E2E5A003CD311B61E00902778AF2A026376D8@SERVER1>
From: Subodh Nijsure <SNijsure@SkyStream.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Cc: Subodh Nijsure <SNijsure@SkyStream.com>
Subject: SCC1 on 860 Ethernet, PortA TxD (PA14) setting.
Date: Sat, 23 Jun 2001 19:18:33 -0700
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am trying to get ethernet on SCC1 going for my custom board.
PA15 is used for RXD (input) and PA14 for TXD (output).

But i noticed that in the "standard" SCC driver (file enet.c) for SCC
both PA14 (RXD) and PA15 (TXD) pins are cleared in
PADIR register. Shouldn't PA15 bit in PADIR register be set to one (output)?

Also Motorola 860 manual lists following step --
"Configure port A to enable TXD1 and RXD1. Set PAPAR( 14,15) and clear PADIR
[ 14, 15 ]
and PAODR [ 14 ]"

Why should TXD be set as input  instead of output?


/Subodh Nijsure


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
