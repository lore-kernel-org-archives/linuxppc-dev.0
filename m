From: "Geiser, Ian" <geiseri@msoe.edu>
To: linuxppc-dev@lists.linuxppc.org
Date: Sat, 23 Sep 2000 07:48:16 -0500 (CDT)
Subject: Odd SCSI Errors
Message-ID: <Pine.LNX.4.10.10009230745020.26149-100000@sleepchamber.geekcentral.msoe.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Greetings,
	I have a powercenter 132 w/ G3 upgrade card
	and a whole mess of SCSI drives.  I have one
	external drive connected to the onboard SCSI
	that randomly gives the following errors:
EXT2-fs error (device sd(8,37)): ext2_readdir: bad entry in directory
#1169550:
inode out of bounds - offset=224, inode=135387292, rec_len=20, name_len=9
EXT2-fs error (device sd(8,37)): ext2_readdir: bad entry in directory
#1169550:
inode out of bounds - offset=224, inode=135387292, rec_len=20, name_len=9
EXT2-fs error (device sd(8,37)): ext2_readdir: bad entry in directory
#1169550:
inode out of bounds - offset=224, inode=135387292, rec_len=20, name_len=9
EXT2-fs error (device sd(8,37)): ext2_readdir: bad entry in directory
#1171563:
inode out of bounds - offset=48, inode=135391981, rec_len=36, name_len=27

It will do this when the machine is idle, or during a build. I have
heard about problems with SCSI on the 7200 series mother boards, could
this be it?  Or is the drive failing?  I have only had it for less than
a year.  I bought it to replace another failed drive.

This problem has occured with 2.2.15-2.2.17 kernels from various places.

Thanks
-ian reinhart geiser

.---------------------------------------------------.
| Ian Reinhart Geiser - Computer Engineering Student|
| HOME: <geiseri@msoe.edu>                          |
| WORK: <geiseri@linuxppc.com>                      |
| WEB:  http://www.msoe.edu/~geiseri                |
`---------------------------------------------------'

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
