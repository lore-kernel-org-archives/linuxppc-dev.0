Message-ID: <400C03B7.7000800@devcom.cz>
Date: Mon, 19 Jan 2004 17:20:07 +0100
From: Jan Damborsky <jan.damborsky@devcom.cz>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: MPC823E SMC/I2C/SPI micropatch
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

we want to use SCCs and SMCs on our custom board
with MPC823E in following configuration:
Ethernets on SCC2 and SCC3,
UARTs on SMC2 and SMC1. Normally it is not possible,
because SCC3 ethernet parameter RAM overlaps SMC1 one.
I have found Motorola micropatch
for SMC/I2C/SPI relocation only for MPC850 and MPC860
processors. They are slightly different (exactly
these patches differ in one word). I would like
to ask if somebody tries to use one of them
for MPC823E. Or if  another microcode patch exists
especially for MPC823E.

                    Regards, Jan Damborsky


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
