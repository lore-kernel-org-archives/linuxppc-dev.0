Message-Id: <6.0.1.1.0.20040510104159.01edf5c0@192.168.2.1>
Date: Mon, 10 May 2004 11:00:08 +0200
To: Dan Malek <dan@embeddededge.com>
From: llandre <r&d2@dave-tech.it>
Subject: Re: Framebuffer driver for LCD controller Epson S1D13305 (aka
  SED1355)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <29EF0B4E-A034-11D8-AAB3-003065F9B7DC@embeddededge.com>
References: <6.0.1.1.0.20040507120138.01d85d60@192.168.2.1>
 <29EF0B4E-A034-11D8-AAB3-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>Anybody knows about some existing drivers for this or similar controllers
>>to use as starting point?
>
>Did you look at all?  There are drivers for the 1355 and 1356 (and their 13xxx
>variants) in the drivers/video directory.   Due to your comment about the
>address/data bus, it doesn't seem like just having the driver is going to
>help the situation :-)

Dan,

unfortunately I had wrong information. S1D13305 is equivalent to SED1335
that is significantly
different from SED1355 (1335 does not provide a full bus interface
address/data) so the driver
Epson epson1355fb.c is not useful :-(
The main problem is that framebuffer memory is not accessible linearly like
a standard RAM. This means
that even graphical environment low-level routines (for example nano-x)
must be rewritten to manage
the read/write operations on framebuffer memory.



llandre

DAVE Electronics System House - R&D Department
www.dave-tech.it


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
