Date: Thu, 10 Jun 2004 13:52:48 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: ok, so now my dynamically-linked minit starts after all.  argh.
Message-ID: <Pine.LNX.4.58.0406101346490.18563@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  gack.  after doing a thorough clean of my software tree, and rebuilding
with a dynamically-linked minit, well, it works.  go figure.

RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 52k init
Trying run_init_process with /sbin/minit
FIFOs opened successfully.
About to start default service.
(hang)

  in other words, i'm back where i was many days ago -- kernel booting,
getting to minit, minit starting, then hanging.  but that's ok, given that
i *expected* things to go south once i got to user space, based on
previous postings here.

  so, my best strategy at this point would seem to be to do the occasional
"bk pull", and rebuild to see when i get to go further in user space.  i
have no clue why a dynamically-linked minit suddenly started to work.
("no, really, i didn't change anything.  honest." :-)

  i'll be watching for new and exciting developments.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
