Date: Sun, 1 Aug 1999 16:10:47 -0400
From: brad allison <jackal@aol.net>
To: Multiple recipients of list <linuxppc-dev@lists.linuxppc.org>
Subject: Running list of R5 bugs
Message-ID: <Pine.SGI.4.00.9908011555120.8611-100000@osiris.office.aol.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Is there a running list of bugs introduced with R5?  Like a bug track list
for linuxppc?

Here are three bugs I've come across in R5:

* You can't call second and third mouse buttons mappings using BootX
kernel arguements (adb_buttons=#,#) like you could in R4.

* ksirc core dumps when you start a /query with anyone.

* gimp can no longer save xpms.  Saving to xpm returns this error:
/usr/lib/gimp/1.0/plug-ins/xpm
: Segmentation fault caught /usr/lib/gimp/1.0/plug-ins/xpm
(pid:951): [E]xit, [H]alt, show [S]tack trace or [P]roceed:           

Those are the three I found in R5 that were not in R4.  All software was
installed straight off the R5 CD onto a Wallstreet G3 Powerbook.

All these worked fine on the same machine with the R4 installation.

-b

--
AOL SAPI 		                        703.265.0908     AIM:jackal242
http://jackal.fudge.org        `I was never more certain of how far away I was
from my goal than when I was standing right beside it.' - Ethan Hawke, Gattaca


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
