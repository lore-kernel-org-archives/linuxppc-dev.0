From: statik@austin.rr.com
Message-ID: <3831F8CA.9466B892@austin.rr.com>
Date: Tue, 16 Nov 1999 18:37:30 -0600
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Problems with kernel
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I recently got LinuxPPC installed on an IBM 7248 and built a kernel image
(2.2.6) that supports the builtin ethernet and it works great.  One problem I'm
having is that the ramdisk image I have to install Linux isn't read properly
with this boot image.  I tried to build a kernel with 2.2.12 and it didn't work.

Anyway, after I boot and pass the options 'root=/dev/fd0 ramdisk_size=8192
load_ramdisk=1' it prompts for root disk #1 and I swap disks and hit enter.
After a few seconds, it starts spouting out error messages

  end_request: I/O error, dev 01:00 (ramdisk), sector XXXX

where 'XXXX' is a number that starts about 10000 and keeps incrementing by 2
and doesn't stop. (I let it go past 1150000 once just to see if it would stop.
That's not to a typo with many 0s, it's 1 million, which is just a few (sarcasm)
more sectors than exist on the floppy)

I know the ramdisk images are good because I originally installed with the
same disks.  Am I missing some kernel options or something?

Any help would be greatly appreciated.

Thanks.
Adam.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
