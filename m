Date: Fri, 3 Sep 1999 17:29:09 -0400 (EDT)
From: Hank De Gregorio <hcd1@acpub.duke.edu>
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: SCSI host detected, but not the drive
In-Reply-To: <Pine.SOL.3.91.990827144757.13651A@godzilla6.acpub.duke.edu>
Message-ID: <Pine.SOL.3.91.990903172713.439A-100000@godzilla6.acpub.duke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


i am installing linuxppc-r4 with the redhat installer.

i get this message (and subsequently a frozen screen) *after* i have 
chosen my root password and clicked ok to reboot:

VFS: Mounted root (ext2 filesystem) readonly.
change_root: old root has d_count=2
Trying to unmount old root ... <3>error -16
Change root to /initrd: error -2
Freeing unused kernel memory: 88k init 4k pmac 8k open firmware
tty_io.c: process 1 (swapper) used obsolete /dev/cua1 - update software 
to use /
dev/ttyS1
tty_io.c: process 1 (init) used obsolete /dev/cua1 - update software to 
use /dev
/ttyS1
tty_io.c: process 1 (init) used obsolete /dev/cua1 - update software to 
use /dev
/ttyS1
tty_io.c: process 1 (init) used obsolete /dev/cua1 - update software to 
use /dev
/ttyS1
tty_io.c: process 1 (init) used obsolete /dev/cua1 - update software to 
use /dev
/ttyS1

does anyone have a clue what's going on with my system?

hank


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
