Message-Id: <200109281516.LAA00192@orchid.cspi.com>
Content-Type: text/plain;
  charset="iso-8859-15"
From: Brian Waite <bwaite@cspi.com>
Reply-To: bwaite@cspi.com
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.4.10 stable tree
Date: Fri, 28 Sep 2001 11:07:18 -0400
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have been working on a stable port of the MVME5100 from the devel tree. I
had everything working from 2.4.9 and I got onot other projects. I just
grabbed the 2.4.10 stable tree and noticed the arch/ppc/boot/simple directory
has been removed. I was using simple/head.S to bring up the board. What
should I be using now? Have you abandoned a simple head.S layout and require
all baords to have their own head.S now? I am just making sure I am not
missing something.

--
Thanks
Brian

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
