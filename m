Date: Thu, 14 Jan 1999 22:25:26 -0700 (MST)
From: Brad Midgley <brad@pht.com>
Reply-To: Brad Midgley <brad@pht.com>
To: Paul.Mackerras@cs.anu.edu.au
cc: linuxppc-dev@lists.linuxppc.org
Subject: floppy vs. read-only
In-Reply-To: <199901131133.WAA00819@tango.anu.edu.au>
Message-ID: <Pine.LNX.3.96LJ1.1b7.990114220022.875A-100000@cricket>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


on intel, mount attempts the mount read-write, the mount fails with EROFS,
and then mount attempts it again ro.

brad

mount("/dev/fd0", "/mnt/floppy", "vfat", MS_NOSUID|MS_NODEV|0xc0ed0000,
0x80507d0) = -1 EROFS (Read-only file system) 

write(2, "mount: block device /dev/fd0 is "..., 67mount: block device
/dev/fd0 is write-protected, mounting read-only) = 67

write(2, "\n", 1 )  = 1

sigprocmask(SIG_BLOCK, ~[], NULL)  = 0

mount("/dev/fd0", "/mnt/floppy", "vfat",
MS_RDONLY|MS_NOSUID|MS_NODEV|0xc0ed0000, 0x8050818) = 0





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
