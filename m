Message-ID: <20001021060725.8637.qmail@kunk.jriver.com>
Subject: 2.4.0-test10 & iMac video failure
To: linuxppc-dev@lists.linuxppc.org
Date: Sat, 21 Oct 2000 01:07:24 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


If I build a kernel from the penguinppc dev tree (as of 10-21) and
use bootx 1.2 for booting, it will not bring up the iMac
rev C mach64 properly. The bootx parameters are the same that
work fine with 2.2.17 (single,video=atyfb:vmode=17:cmode=32). If the
"no video driver" box is UNchecked, the screen goes blank on
boot and stays that way. If the box is checked I get the debug messages
but nothing after the boot exit.

The machine continues to boot works fine via telnet. At first look
through the messages, it appeared related to the PowerBook 2.4.10
vid bug which had been fixed so I guess that's not it...

Any ideas?

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
