Date: Mon, 14 Jul 2003 13:19:10 -0600 (MDT)
From: daRonin <daronin@digimerc.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: firewire in 2.4.21-ben2
Message-ID: <Pine.LNX.4.56.0307141313050.1861@daronin.digimerc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

  I just upgraded to 2.4.21-ben2 kernel. And I can't mount my firewire
HDDs any longer.

  These are the commands I am executing:

  modprobe -k ieee1394
  modprobe -k ohci1394
  modprobe -k sbp2
  modprobe -k raw1394
  modprobe -k sd_mod
  mount /dev/sda2 /mnt/fire

  Judging by the logs everything seems to go fine up to inserting sd_mod.
sbp2 module seems to see the device and such.

  But after inserting sd_mod absolutely nothing happens. I tried rmmod'ing
the modules and inserting them again, tried to switch the order around,
etc. No luck...

  After I reboot back in 2.4.20-ben10 everything works fine...

daRonin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
