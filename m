Message-Id: <199901220857.AAA10924@avocet.prod.itd.earthlink.net>
Subject: Embedded ppc project
Date: Fri, 22 Jan 1999 02:57:21 -0600
From: Pink X <PinkX@earthlink.net>
To: <linuxppc-dev@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Can someone give me  a brief overview of how the boot process works for 
linuxppc on non-mac, non-open firmware hardware?

For instance, we're looking at a custom processor board for a project... 
basically it will have a CPU, a DiskOnChip of about 24MB, RAM and a 
drive.   Will it be hugely difficult to get linuxppc to boot out of the 
DoC (with a kernal and compress root ramdisk in the DiskOnChip)  Does the 
kernel make assumptions about there being certain types of hardware or a 
open firmware roms being there?  Will it be hugely difficult for (very 
experienced programmers who have worked on unix but not linux 
specifically) to get the kernal hacked to our hardware formfactor (not 
counting any I/O work, just booting in this environment.)

Any advice appreciated!  We may go with the RPCLite board, but we kinda 
need a 603e level of power.  (So any 603e @200+MHz embedded boards would 
be great to hear about, we've not found any yet.)

Thanks-

Jay

--
Worried about Y2K?   You should have bought a Macintosh.
(It also costs less, is twice as fast, and makes you more productive.)


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
