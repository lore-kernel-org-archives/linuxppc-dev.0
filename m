Message-ID: <41EA756DBC9FD0118CFC0020AFDB5C5A188DC9@tcint1ntsrv>
From: Zehetbauer Thomas <TZ@link.topcall.co.at>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Uncompress Ok, but cannot run linux kernel...
Date: Tue, 8 May 2001 12:43:15 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I stumbled into the same problem a while ago.

While I did not use a hardware debugger I used the sample demonstrating
serial output to find that the Montavista kernel stops at the rfi
instruction which is used to simultanoeusly turn on instruction and data
address translation and to set the instruction pointer to the (remapped)
start_here label. Unfortunately I lost my PPC hardware (405GP Walnut
board) before I could find any solution.

Regards
Tom

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
