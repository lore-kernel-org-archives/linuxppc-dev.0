Message-ID: <37A9A9E0.2D7B8755@mitre.org>
Date: Thu, 05 Aug 1999 11:12:32 -0400
From: Charles Lepple <clepple@mitre.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: initrd troubles
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Did initrd support break in 2.3.x? I'm trying to load an inital ramdisk
on a Dy4 card, and the ramdisk.image.gz data is preserved when the card
boots into linux (passes a simple checksum test). However, I can only
list directories in the filesystem -- any time I try and read a
pre-existing file, it is empty (stat calls return a non-zero size,
though), and when I write a file and read it back, it seems to work. (Of
course, this means that I can't exec() anything that was on the
filesystem when the card boots...) Anyone seen this?

--Charles Lepple
clepple@mitre.org


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
