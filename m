Message-ID: <3C4596DB.1080200@esd-electronics.com>
Date: Wed, 16 Jan 2002 16:06:03 +0100
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: David Updegraff <dave@cray.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: a MINIMAL405 submodel
References: <3C44A4AF.9000302@cray.com> <3C44A85E.1090108@embeddededge.com> <3C458B66.7020704@cray.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi David,

what do you mean by a peripheral-less 405gp ? It is possible to deselect all OCP functions
from the kernel config. You do not need a new plattform to do this.

I am using the current 2.4.x devel tree with the CPCI405 config on a custom 405CR board.
The 405CR does not have PCI or Ethernet. So its nearly a peripheral-less GP. I only had to deselect PCI and
Ethernet.

So why a new plattform ?

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
