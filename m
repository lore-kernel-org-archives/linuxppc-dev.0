Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC05F4A@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Question: mvista kernel ... how do i enable SCC1 for enet
Date: Tue, 17 Dec 2002 18:00:18 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have my kernel running with SMC1 UART support and would now like to add
SCC1 support.

FYI: My platform is based on a FADS board ... but some of my SCC pins have
moved.

1.) What kernel modules do I need to enable to get ENET on SCC1? I have
added basic network support ... but see no SCC1 under CPM settings ... is it
there by default ...

2.) Do I have to change anything in the kernel to accommodate my new SCC
pins?

As always thanks for the assistance!

Jim

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
