Date: Sun, 4 May 2003 17:20:51 -0500 (CDT)
From: "Milton D. Miller II" <miltonm@realtime.net>
Message-Id: <200305042220.h44MKpiI034434@sullivan.realtime.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.5 and serial console
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I Olaf.

I just ran into this myself.  Either enable 8250 and 8250 console, don't
build the prep boot loader, or ignore the fact the prep boot loader doesn't
link (and since its after chrp and pmac, that's the one I chose :)

milton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
