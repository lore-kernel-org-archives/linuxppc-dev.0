From: "Brian Padalino" <bpadalino@perigee.com>
To: <zjzhou@newrocktech.com>, <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: how to use busybox to make a ramdisk?
Date: Fri, 29 Aug 2003 12:42:12 -0400
Message-ID: <DGEEIPOFGGPOACEFBGGCEEAECBAA.bpadalino@perigee.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <000701c36d4a$455483c0$9702a8c0@newrock2>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John,

I kind of cheated and used the DENX ELDK (http://www.denx.de) ramdisk that
came with his stuff (mainly for the /dev entries).

But there is also a good tutorial on how to create ramdisk images.

http://www.linux.org/docs/ldp/howto/Bootdisk-HOWTO/buildroot.html

The only thing that I do differently is that I use a loopback device like
so:
  mount -t ext2 filename /mnt/image -o loop
This stops mount from complaining to me and I like that.

Hope this helps and good luck!

Cheers,
Brian Padalino


-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of John
Zhou
Sent: Thursday, August 28, 2003 5:54 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: how to use busybox to make a ramdisk?



Hi all,

I want to get some detail documents about how to use busybox to make a
ramdisk!!  Does anybody know? Is it to use mkinitrd ?

Thanks & Regards
John Zhou


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
