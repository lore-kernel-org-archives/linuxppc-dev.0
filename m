Date: Wed, 6 Sep 2000 12:26:19 -0400 (EDT)
From: "Mark S. Mathews" <mark@absoval.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: User mode read/write RPX-Lite flash
Message-ID: <Pine.LNX.3.96.1000906122107.24138A-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Folks,

I have a small userland utility that I use for reading and writing raw
flash on the RPX-Lite (write a file/read a file).  At the moment, it's
hard-coded for 16MB boards using the AM29DL323C parts.

I'm about to add some stuff to make it more flexible in terms of flash
size population options and parts.

I remember some folks talking about some JEDEC CFI generic code and was
wondering if anyone's done something similar in userland.

Thanks,
-Mark

Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.linux-wlan.com
P.O. Box 941149            e-mail: mark@linux-wlan.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
