Message-ID: <3C566357.7060307@esd-electronics.com>
Date: Tue, 29 Jan 2002 09:54:47 +0100
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: I2C support for 405GP
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

is anybody working on the I2C driver for the IBM 405GP ?
The driver was in the 2.4.2 Kernel from Montavista, but it dissapeared
from the devel tree a long time ago. I tried to take that old sources
and merged the i2c stuff into a more recent 2.4 devel kernel. It did not work.

This leads to some questions:

1) Is anybody currently workig on this issue ?
2) Does anybody have a local working i2c driver for the 405 ?
3) Is there a special reason why the i2c support dissapeared ?

I read sometime ago on the i2c project site, that they care about the 405
i2c driver. Is this true ?

Matthias

--
-------------------------------------------------------------------------

                             _/_/_/_/   Matthias Fuchs
                            _/_/_/_/   Dipl.-Ing.
                           _/_/_/_/   matthias.fuchs@esd-electronics.com

       _/_/_/   _/_/_/_/_/_/_/      esd electronic system design gmbh
     _/   _/  _/             _/    Vahrenwalder Str. 207
    _/   _/    _/_/_/   _/   _/   D-30165 Hannover
    _/             _/  _/   _/   Phone: +49-511-37298-0
     _/_/_/_/_/_/_/   _/_/_/    Fax:   +49-511-37298-68

-------------------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
