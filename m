Date: Tue, 19 Jan 1999 02:18:17 -0500 (EST)
From: Scott Venier <scottven@umich.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: problem with 8500
Message-ID: <Pine.SUN.4.05.9901190159490.10492-100000@toastman.us.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've got an 8500/120.  I've had linuxppc on it for a long time (2.0.25 is
the kernel that came with it).  I recently got another harddrive, so I
though I'd install pre-R5 on it.  Here's where I ran into the problems.  I
posted them on linuxppc-user, but didn't get any response.

The problem comes when mounting the newly created filesystems.  The mount
fails when done from the installer or with mount on tty2.  tty4 shows me
what the problem is...  My root partition is supposed to be sdb2
(major/minor 8,18).  The error message on tty4 is (sorry, I can't paste
the exact one) VFS: couldn't find ext2 fs on device 08:12.  I check the
device file and it is correctly set to 8,18.  I've created new device
files at 8,18.  Nothing seems to help.  It always tries 08:12.

This happens with 2.2.0pre2, 2.1.121, 2.1.131 (all booted from BootX)  I
tried to boot the 2.0.25 kernel that my old install uses, but BootX just
freezes on that kernel.  The old install still works fine.  It's on sdc.
The old install has the same problem with trying to mount the new drive.

sda is on the internal scsi chain, id 0 (mac os)
sdb is on the internal scsi chain, id 4
sdc is on the external scsi chain, id 1

This one has me quite stumpped.  I can't come up with any reason why it
tries a different minor number then the one on the device file.

Thanks

Scott

=====================================================================
Scott Venier               *ResComp Senior Network Support Technician
scottven@umich.edu                        *Consultant for Ingematics,
scott@compu-aid.com                     a division of Compu-Aid, Inc.
---------------------------------------------------------------------
I'm not as dorky as I used to be,
                             only because now it's cool to be a geek.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
