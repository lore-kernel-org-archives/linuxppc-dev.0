Message-ID: <371BBD46.246D9D0F@ibm.net>
Date: Mon, 19 Apr 1999 23:33:26 +0000
From: root <roboj@ibm.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Kernel 2.2.6-ac1 problem
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I compiled the latest kernel from source and I created vmlinux with no
problems.  After installing it in my system folder on my mac partition
and booting linux again, I get I/O errors somewhat randomly.
The message that is displayed is "No space left on device".  The file
/var/log/messages conatins the following lines:

Apr 19 23:23:07 localhost kernel: EXT2-fs error (device ide0(3,4)):
ext2_new_block: Free blocks count corrupted for block group 13

I had the same problem when compiling and testing the 2.2.5 kernel as
well, but I found no other references to a similar problem in the
mailing lists and newsgroups.  Can anyone help or offer advice?

-J. Robokos

System config:
Powerbase 603,
40MB Ram,
Maxtor IDE hard drive (Master),
Seagate IDE hard drive (Slave)


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
