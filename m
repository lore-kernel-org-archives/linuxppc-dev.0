Date: Sun, 1 Aug 1999 17:50:24 -0400
From: brad allison <jackal@aol.net>
To: Multiple recipients of list <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-user@lists.linuxppc.org
Subject: internal zip drive support on a G3 laptop
Message-ID: <Pine.SGI.4.00.9908011740270.8980-100000@osiris.office.aol.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



It doesn't appear that I can mount my internal zip drive from either bay.

I'm using gdr's 2.2.10 off of (http://gdr.free.fr/linux.html).

bash-2.03# dmesg |grep -i zip
hdc: IOMEGA MAC ZIP 100 MAC ATAPI, ATAPI CDROM drive

bash-2.03# mount -t hfs /dev/hdc /zip
mount: block device /dev/hdc is write-protected, mounting read-only
mount: wrong fs type, bad option, bad superblock on /dev/hdc,
       or too many mounted file systems

I've tried it in both the left (hde) and right (hdc) bays.

Since it's a mac formatted zip disk it should mount up as hfs file system.

Is there support in the 2.2.10 kernel for this or am I doing something
wrong?

I also backed out and testing it with the "Very Stable G3 laptop" kernel
from the CD which is 2.2.1 and I get the same error.

-b

--
AOL SAPI 		                        703.265.0908     AIM:jackal242
http://jackal.fudge.org        `I was never more certain of how far away I was
from my goal than when I was standing right beside it.' - Ethan Hawke, Gattaca


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
