Message-ID: <B25E2E5A003CD311B61E00902778AF2A02044488@SERVER1>
From: Brian Kuschak <brian.kuschak@skystream.com>
To: "'Matthias Fuchs'" <matthias.fuchs@esd-electronics.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: I2C for IBM405CR under Hardhat Linux
Date: Thu, 15 Mar 2001 11:42:19 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You need to select:

CONFIG_PPC405_I2C_ALGO=y
CONFIG_PPC405_I2C_ADAP=y

These drivers are part of the latest M.V kernel.

linux/drivers/i2c/i2c-adap-ppc405.c
linux/drivers/i2c/i2c-algo-ppc405.c


-----Original Message-----
From: Matthias Fuchs [mailto:matthias.fuchs@esd-electronics.com]
Sent: Thursday, March 15, 2001 4:21 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: I2C for IBM405CR under Hardhat Linux



Hello,

I am trying to access my i2c eeprom (custom board) from MotaVista's
HardHat Linux (kernel 2.4.0-test2).

Here is a snippet from my kernel config:
#
# I2C support
#
CONFIG_I2C=y
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_CHARDEV=y

How can I enable i2c support for the 405 ? /proc/bus/i2c is empty. I
expect the 405 i2c adapter listed there ! Am I right ?

Matthias
--
-------------------------------------------------
\ Matthias Fuchs                                 \
 \ esd electronic system design Gmbh              \
  \ Vahrenwalder Straﬂe 205                        \
   \ D-30165 Hannover                               \
    \ email: matthias.fuchs@esd-electronics.com      \
     \ phone: +49-511-37298-0                         \
      \ fax:   +49-511-37298-68                        \
       --------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
