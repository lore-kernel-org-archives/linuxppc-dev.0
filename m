From: Wolfgang Haeuptli <whaeuptli@bluewin.ch>
To: linuxppc-dev@lists.linuxppc.org
Subject: scanner not recognized (interrupt in idle phase?)
Date: Sun, 7 Nov 1999 13:56:55 +0100
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <99110714573501.00535@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

on startup, I see this message (mesh: interrupt in idle phase?) while the system
checks the scsi bus. This is on a kernel 2.2.9 with sg-driver included, on a
performa 6400 with a UMAX Astra 1200S scanner (which works on the MacOS 
side, b.t.w.).

Any scsi-crack around that could give me a pointer how to solve the problem? 
(Do I need another low-level driver for my scsi-chip ... which would be what??)

Thanks for a hint

Wolfgang Haeuptli


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
