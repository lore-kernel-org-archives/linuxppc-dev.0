Date: Tue, 25 May 1999 16:50:52 -0400 (EDT)
From: "Jason Y. Sproul" <jsproul@mail.wesleyan.edu>
Reply-To: jsproul@mail.wesleyan.edu
To: linuxppc-dev@lists.linuxppc.org
Subject: controlfb update
Message-ID: <Pine.GSO.4.05.9905251650320.14882-100000@mail.wesleyan.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've got controlfb detecting dual-bank VRAM properly now, which is a
superset of Ben's earlier patch.

Anyone know why a system with only bank 2 VRAM would have it at 0x600000
off the framebuffer base, whereas a dual-bank system has bank 1 at 0x0 off
and bank 2 at 0x200000 off, respectively? Seems peculiar.

Now that the dual-bank stuff is in, my boot logo and colours in X are
rather munged - it looks like the cmap is trashed. Both of these are fine
if I just assume bank 2 is there, but not if I probe for it. I'm going to
try to fix that, but I'm not sure what's going on. Any ideas? Might it be
that I changed the colour mode returned to the fb subsystem when using
CMODE_32 from DIRECTCOLOR to TRUECOLOR?

........................................................................
Jason Y. Sproul                    http://www.con.wesleyan.edu/~jsproul/
jsproul@wesleyan.edu            jsproul@iced.com    http://www.iced.com/
     Eagles may soar, but weasels don't get sucked into jet engines.



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
