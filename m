Message-ID: <3CA05D0A.FA7A25FE@imc-berlin.de>
Date: Tue, 26 Mar 2002 12:35:38 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8xx, SCC and pppd
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I want to ppp to my custom board, i.e. connect a modem to my board and
react on incomming calls.
I suppose I have to run some mgetty/pppd combination.

Has anyone used the mgetty/pppd (Point to Point Protocol daemon) with
the MPC8xx's SCCs?

I want to know if I actually need to route the Ring Indicator from the
modem to one of MPC8xx'S external IRQs? Or would it be enough for mgetty
(or pppd) to react on Carrier Detect (with is included in the SCC)?

Thanks,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
