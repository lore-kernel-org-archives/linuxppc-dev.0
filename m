Message-ID: <40597103.3090704@fh-landshut.de>
Date: Thu, 18 Mar 2004 10:50:59 +0100
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux and RTAI on the Motorola VME Boards
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I'm doing a university project on Linux in realtime applications.

The ultimate goal is to evaluate realtime options for the MVME 2100,
MVME 5500, and VMIVME 7050 (ok, that's an Intel one, just mentioned it
for completeness :) ).

Since hard realtime is preferred, kernel preemption doesn't seem to be
good enough, so I wanted to focus on RTAI. I found several Linux drivers
for CPU and board hardware, and several drivers for the Tundra Universe
II PCI-VME bridge.

Unfortunately, I didn't find very much documentation on RTAI. I'm
actually wondering what I need to communicate with the VME bus in
realtime. Can I safely call the Linux drivers functions? Do I need to
use a modified version of the driver? What features in a driver do not
mix with RTAI?

I've read on the list Xavier Grave seemed to have done something very
similar on the MVME 5500, but he seems to have not published all of it,
at least not now.

On a similar issue:
I found a discussion about problems using the open_pic driver with the
MVME 2100, and considerations about a possible rewrite of the driver to
accomodate more flexibility. Has someone done it by now?

Thanks in advance,
Oliver Korpilla
CS student at the University of Applied Sciences at Landshut, Germany

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
