Date: Tue, 8 Dec 1998 14:02:37 -0500 (EST)
From: satadru pramanik <satadru@umich.edu>
To: linuxppc-list@lists.linuxppc.org
cc: linuxppc-dev@lists.linuxppc.org
Subject: scsi kernel panics
Message-ID: <Pine.SOL.4.05.9812081356410.25934-100000@asteroids.rs.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I recently sent a message to this list regarding kernel panics when doing
disk intensive tasks with either the external scsi bus, or th one through
an Adaptec 2940UW card.  External disks are recognized, but when doing
things like tar zfxv file.tar.gz, the kernel panics.  Anything over
400kb/sec access it seems.  After a reboot following kernel panic, the
kernel often panics again while fscking the external disk.  I have gotten
responses from others confirming what seems to be a very serious bug.  Can
anybody suggest workarounds/ code fixes/ ways to nail down the error any
further?  I don't see how the 2.1 kernels can be declared 2.2 until
something of this serious of a magnitude is fixed.  

My system configuration includes a 2.1.130 kernel, on a 7600/132 with 80
MB of ram, and a 126 MB swap disk.

thanks.

----
satadru pramanik www.umich.edu/~satadru
Do, or do not.  There is no try.
-Yoda
---


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
