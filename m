Date: Mon, 7 Jun 2004 11:55:33 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: newest "bk pull" of 8xx tree still builds a kernel that hangs
Message-ID: <Pine.LNX.4.58.0406071152260.14264@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  having just got back from vacation, i may have missed some of the latest
developments.  i just did a "bk pull" from the linuxppc-2.5 tree, rebuilt
the kernel for my 8xx board and, just like before i left, the kernel hung
almost immediately upon booting:

Linux/PPC load: console=ttyS0,9600 rw root=/dev/ram0 init=/sbin/minit
Uncompressing Linux...done.
Now booting the kernel
(hang)

should i be expecting this?  once upon a time, of course, i got all the
way to user space before the hang.  have there been some recent patches to
cause this latest behaviour?  i haven't messed with the config file in
quite some time.  should i?

thanks for any guidance.

rday


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
