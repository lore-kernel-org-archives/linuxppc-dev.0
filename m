Date: Sun, 15 Nov 1998 18:27:09 -0700 (MST)
From: Brad Midgley <brad@pht.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: floppy driver bug: write-protect
Message-ID: <Pine.LNX.3.95.981115182106.10912A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


is this a known bug?

on intel linux, if you try to mount a write-protected floppy disk
read-write, the mount succeeds but is demoted to read-only. 

the current pmac kernel will mount the disk read-write and will allow
"writes" to the disk. the writes even appear to succeed and the mounted
filesystem returns really strange results when you look at it (it's
caching the "writes" and everything seems normal until uncached data has
to be loaded from the disk!)

is it known how to query the drive for the write-protect status? does this
problem affect any other removable media?

brad


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
