Date: Tue, 15 Aug 2000 13:45:05 -0400 (EDT)
From: "Kevin M. Myer" <kevin_myer@iu13.k12.pa.us>
To: linuxppc-dev@lists.linuxppc.org
Subject: Control fb problem on 8500
Message-ID: <Pine.LNX.4.21.0008151339190.734-100000@pegmatite.iu13.k12.pa.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

A couple of issues have cropped up with my PowerMac 8500.  I am running
Paulus' 2.4.0-test6 kernel and my console has developed a sort of mirror
image on the far right one-eighth of the screen.  Basically, everything on
the screen is mirrored in that eighth of the screen albeit much
smaller.  For example, as I type this, tiny white lines are being drawn to
my right.  If I were to `ls --color` a directory, different color lines
show up.  This behaviour wasn't there in Paulus' 2.4.0-test1-ac21 kernel
of a few rsyncs ago.

Secondly, the video chip doesn't show up on the PCI bus.  Although XFree86
4.0 apparently supports the controlfb (which is what the 8500 has), it
also needs a BusID to be used.  Am I out of luck with using XFree86 4.0 or
newer with my machine?  Or generically, is anyone without a card on the
PCI bus out of luck?

Thanks,

Kevin

--
Kevin M. Myer
Systems Administrator
Lancaster-Lebanon Intermediate Unit 13
(717)-560-6140


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
