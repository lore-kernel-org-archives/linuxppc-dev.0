Date: Wed, 17 May 2000 11:53:01 -0400
From: Josh Huber <huberj@wpi.edu>
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: quik booting on a wallstreet
Message-ID: <20000517115301.A332@mclinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Does anyone have quik working on a wallstreet?  I've put the OF patches
thanks to Apple's SystemDisk app in, and I used to have this working (this
is really annoying :)...but can't seem to get it going again.

Any help would be greatly appriciated...

I tried using:
boot-device ide0/disk@0,0 ide0/disk@0:0 ide0/disk@0:11 ide0/disk@0,11

My root partition is 11, which has the kernel as well, in /boot/vmlinux.

Josh

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
