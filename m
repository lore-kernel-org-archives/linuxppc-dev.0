Date: Thu, 11 Feb 1999 19:10:08 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: OF and NetBooting
Message-ID: <Pine.LNX.4.05.9902111905490.12241-100000@p12-42.hartford.dialin.ntplx.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,
  After playing around a bit more with my iMac, I was wondering if anyone
knew just what was going on here..  First, I've gotten the iMac to
NFS-boot with BootX, and verified that bootp is setup right (ie it sets up
the network, and I can tftp in the file from OF).  However, when I try and
load a kernel from OF (either hd:vmlinux or enet:0,vmlinux) I get CLAIM
failed.  Has anyone gotten past this?  I'm thinking it might be something
we do really early on, as netbsd does boot (enet:0,netbsd.generic)

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
