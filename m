Message-Id: <l03010d00b29c9d33a288@[207.244.110.41]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 15 Dec 1998 18:17:38 -0500
To: linuxppc-user@lists.linuxppc.org
From: Ezekiel <dwheeler@eris.cs.umb.edu>
Subject: power center pro framebuffer not working
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


accel X does not work with the onboard ATI RAGE II graphics on the power
center pro 210. my configuration is such: kernel: 2.1.130, fb0 is
configured as  mknod fb0 c 29 0(i think thats it, I basically took  the set
up out of the fb readme that came with 2.1.130)I have the  appropriate
stuff compiled into the kernel. I will gladly provide a dmesg or .config if
wanted.  4mb video, also an XclaimVR card with 4 mb ram on it in the 2nd
pci slot (not in use, due to lack of monitor). If anyone has any info on
this I'd appreciate getting the low-down on it, otherwise, I suppose this
is a bug report on either 2.1.130  or XF68_FBDev 121098

-zk

<><><><><><><><><><><><><><><><><><><><>
Donn Ezekiel Wheeler
dwheeler@eris.cs.umb.edu
dwheeler@mars.cs.umb.edu
http://www1.shore.net/~cp/zk/zk.html



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
