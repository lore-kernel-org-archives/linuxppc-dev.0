From: jlhagen@collins.rockwell.com
Subject: trouble creating ramdisk over 8MB - could someone explain this to me
To: linuxppc-embedded@lists.linuxppc.org
Date: Thu, 1 Feb 2001 16:13:15 -0600
Message-ID: <OFCB2243A7.F8689577-ON862569E6.00792F78@collins.rockwell.com>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm trying to set up a 10MB ramdisk for our VME boards. I'm running in to
this

dd if=/dev/zero of=/dev/ram bs=1k count=10240
dd: /dev/ram: No space left on device
8193+0 records in
8192+0 records out

and

mke2fs -vm0 /dev/ramdisk 10240
mke2fs 1.18, 11-Nov-1999 for EXXT2 FS 0.5b, 95/08/09
mke2fs: Filesystem larget than apparent filesystem size.
Proceed anyway? (y,n)

For 8MB dd and mke2fs don't give me problems and changing
drivers/block/rd.c rd_size to 8192 works as expected but I can't
figure out why larger than 8 gives me problems.

I would appreciate the help.
John

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
