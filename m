Date: Tue, 30 Nov 1999 20:15:28 -0500 (EST)
From: Jon Howell <jonh@cs.dartmouth.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: installer default inode count
Message-ID: <Pine.GSO.3.96.991130201013.24058E-100000@sitka.cs.dartmouth.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I recently installed LinuxPPC 1999 Q3, and today I ran out of inodes.
My 3G disk is only 67% full. It turns out my inode ratio is about
one inode per 32KB. The default for mk2efs is 4KB (-i 4096).
32KB seems extreme. Indeed, I see from the mailing list archive
that someone else ran into the same problem in September
(http://lists.linuxppc.org/listarcs/linuxppc-dev/199911/msg00047.html).

Hollis' reply hints that the installer does this on purpose, but
I couldn't tell for sure. Could whoever maintains the installer look
into changing the inode ratio to something lower, or is the 32KB ratio
intentional (but unfortunate)?

Now to find a big disk to back up to...

Thanks,

	--Jon

 Jon Howell  jonh@cs.dartmouth.edu     finger jonh@cs.dartmouth.edu | pgp -kaf
 http://www.cs.dartmouth.edu/~jonh     170AE827  ADAB6559  9C2E3DB3  37BD72EC


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
