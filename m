Message-ID: <000001c0a273$b7765c20$74dee783@lboro.ac.uk>
From: "Peter Uttley" <P.Uttley-97@student.lboro.ac.uk>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: How can I slim down libc
Date: Thu, 1 Mar 2001 15:36:18 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hope someone can point me in the right direction.

I'm currently developing an embedded system based on an MPC-850, and
everything going quite well, however I'm currently mounting my file system
on NFS and now want to run from a ram disk.
Unfortunately I only have 8MB of RAM to play with and Libc on it's own is
4MB, I've tried removing debug information but this doesn't get me down much
further.

Any help on this matter would be highly appreciated,

Regards,

Pete.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
