Message-ID: <D73A25AA6E54D511AD74009027B1110F5BB008@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Jan Damborsky'" <jan.damborsky@devcom.cz>,
	linuxppc-dev@lists.linuxppc.org
Subject: RE: MPC823E SMC/I2C/SPI micropatch
Date: Mon, 19 Jan 2004 11:29:47 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've used the one in the linuxppc_2_4_devel tree with success.
http://ppc.bkbits.net
It is found in directory arch/ppc/8xx_io

-----Original Message-----
From: Jan Damborsky [mailto:jan.damborsky@devcom.cz]
Sent: Monday, January 19, 2004 11:20 AM
To: linuxppc-dev@lists.linuxppc.org
Subject: MPC823E SMC/I2C/SPI micropatch



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
