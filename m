From: "Bob White" <bwhite@perigee.com>
To: linuxppc-embedded@lists.linuxppc.org
Date: Mon, 03 May 2004 12:47:43 -0400
MIME-Version: 1.0
Subject: Dual-Port SRAM
Message-ID: <40963F6F.31001.1A36BB44@localhost>
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've got a board with a dual-port SRAM attached to the 440GP on the
peripheral bus (at CS1_N).  I can map the TLB and access the device
from the bdi2000 and the u-boot command prompt.

What configuration is necessary to map this memory into the kernel?
Can you point me to some examples?  How does it then get accessed from
a user program?

Thanks.

Bob
--
Robert B. White        Perigee, A Division of Sensis Corp
Software Design Engr   316 Commerce Blvd.
TEL: 315.453.7842x29   Liverpool, NY  13088
FAX: 315.453.7917      www.Perigee.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
