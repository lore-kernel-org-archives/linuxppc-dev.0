Message-ID: <20011113155734.28247.qmail@kunk.jriver.com>
Subject: E15 Carolina Frame Buffer Driver for 2.4
To: linuxppc-dev@lists.linuxppc.org
Date: Tue, 13 Nov 2001 09:57:34 -0600 (CST)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have gotten the 2.2 framebuffer driver for the E15 (internal)
display adapter in the IBM 7248-133 43p (carolina Prep MB) to
work (on my machine anyway) in 2.4. This provides a way to
run X with the 2.4 kernels on this hardware.

Here is a patch against the benh rsync tree from last night...

http://www.qbjnet.com/~bob/e15fb-2.4.15-pre3-benh-patch

It would be interesting to hear if it works on other variations
of the 7248.

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
