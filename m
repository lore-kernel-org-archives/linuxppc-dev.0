Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: eth0 configuration
Date: Mon, 29 Mar 2004 09:25:18 -0300
Message-ID: <05866645C8E0B842836A1E91B2AD6B7F0147DDA8@CUR1006V.br002.siemens.net.br>
From: "OTAVIO ISAMU SUGENO" <otavio.sugeno@siemens.com>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody.
I am using ELDK 3.0 in my custom board with MPC860T, instead of old
HHL_20, and I am trying to run Linux kernel 2.4.24. I have two problems,
perhaps someone can help me:
1. eth0 (FEC) does not perform link auto negotiation: FDX, HDX,
10/100Mbps;
2. also IP auto config, using RARP, does not happens.

Can anyone tell me what is happening to this functions do not be
executed?
Which function "open" Ethernet driver to perform link auto negotiation
and in which function call IP auto config?

Thanks.

Otavio I. Sugeno

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
