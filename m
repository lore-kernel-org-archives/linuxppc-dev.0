Message-Id: <6.0.1.1.0.20040507120138.01d85d60@192.168.2.1>
Date: Fri, 07 May 2004 12:06:45 +0200
To: linuxppc-embedded@lists.linuxppc.org
From: llandre <r&d2@dave-tech.it>
Subject: Framebuffer driver for LCD controller Epson S1D13305 (aka
  SED1355)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have to write a framebuffer driver for the controller Epson S1D13305 (aka
SED1355).
Unfortunately it does not provide both address and data buses so the access
to video memory is a little bit more complicated.
Anybody knows about some existing drivers for this or similar controllers
to use as starting point?


Regards,

llandre

DAVE Electronics System House - R&D Department
www.dave-tech.it


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
