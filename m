MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14803.24024.683420.911271@esb.bbn.com>
Date: Thu, 28 Sep 2000 11:03:52 -0400
From: R Shapiro <rshapiro@bbn.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: beige g3 rage II xf4.0.1 and miBoot
Reply-To: rshapiro@bbn.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just to add one more data point (as if another were needed :).  I
tried switching from BootX to miBoot on the rev. a beige g3 minitower.
It boots fine but then can't run xf 4.0.1 at all, even with the fbdev
driver and a single Screen/Device pair.  The symptom is the same as
using ati drivers in a BootX boot: no errors in the log, no core file,
just an endlessly ringing bell and a hosed linux that I have to
three-finger reboot (I can't get to a console and or connect via ssh
to shut it down cleanly).

I plan to try quik-booting as soon as I can figure out the boot-device
syntax for ide drives (I've only configured quik-booting on scsi up
til now).

--
rshapiro@bbn.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
