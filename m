Date: Sun, 2 May 1999 19:54:55 -0400 (EDT)
From: "Jason Y. Sproul" <jsproul@mail.wesleyan.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Mozilla for PPC
Message-ID: <Pine.GSO.4.05.9905021943190.2072-100000@mail.wesleyan.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Vier <nester@erols.com> posted back in March about the need for someone
to hack up a PowerPC linkage function for XPCOM. Netscape's XPCOM will be
essential to Mozilla in the near future, and the functions in question are
only a few dozen lines long. I've been in touch with the module owner about
doing this, but I won't be able to work on it for at least a week or two
(possibly more). I'm also not familiar with LinuxPPC calling conventions
(although I am familiar with other ABIs, and with PPC asm).

Furthermore, it appears that a pre-R5 glibc2 system is necessary to make
Mozilla work at all, and I've yet to set that up. I've got a partition I
can use, but I have to clean it up and download and install pre-R5. And
hopefully R5 will be out soon anyway.

Does someone else want to volunteer for this? Alternatively, could anyone
point me to a good reference on the LinuxPPC ABI? Extra bonus points if you
can make Mozilla work on my R4 system... Thanks!

........................................................................
Jason Y. Sproul                    http://www.con.wesleyan.edu/~jsproul/
jsproul@wesleyan.edu            jsproul@iced.com    http://www.iced.com/
     Eagles may soar, but weasels don't get sucked into jet engines.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
