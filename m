Message-ID: <3AB0B3A0.120FA5A2@esd-electronics.com>
Date: Thu, 15 Mar 2001 13:20:48 +0100
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: I2C for IBM405CR under Hardhat Linux
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
