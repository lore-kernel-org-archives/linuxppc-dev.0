From: jlhagen@collins.rockwell.com
Subject: plain 2.2.17 works on mvme2604 - learning more
To: linuxppc-embedded@lists.linuxppc.org
Date: Thu, 9 Nov 2000 11:31:50 -0600
Message-ID: <OF8AB847EB.E00BE165-ON86256992.005F12D8@collins.rockwell.com>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

First thanks for the nfs suggestions. The 'root=/tftpboot/192.168.1.5 rw '
works as expected.

Second I got a response back from someone using a fresh (kernel.org) 2.2.17
build on their mvme2303 boards( thanks xavier) . So I gave it a shot and
picked up the arch/ppc/boot/zImage and it loads/boots just fine. It is also
mounting the NFS root file system as expected.

So I just wanted to put this in the list for others to find.  I hope this
is not an indication of duplication of effort on Gabriel's and ppc kernel
hackers. That would be wasting too much talent.

JH


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
