From: bob@kunk.jriver.com
Message-ID: <19990920032528.2322.qmail@kunk.jriver.com>
Subject: 2 key rollover in 2.2.10 and beyond
To: linuxppc-dev@lists.linuxppc.org
Date: Sun, 19 Sep 1999 22:25:28 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



It seems that the older usb keyboard driver (<2.2.7) handles keyboard rollover
much better than the new usb keyboard driver. The old one APPEARS to be
doing n-key rollover whereas the new one APPEARS to only be doing 2-key
rollover. Is this a by-product of the usb to adb conversion?
It's really annoying. Perhaps I will try to hack in the old rollover routines.

Bob
-- 
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
