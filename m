Date: Tue, 4 Dec 2001 10:22:12 -0700 (MST)
From: Derrik Pates <dpates@dsdk12.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Rage128 support for resolutions less than panel resolution?
Message-ID: <Pine.LNX.4.40.0112041017530.8200-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I know it's not in Ben's kernel yet, but I read something about adapting
the code that had been added to the Radeon framebuffer code to allow
resolutions lower than the LCD panel's native resolution (like on
laptops). I tried looking at the radeonfb source, and it's looking up a
devnode property on the display device that I don't see on this iBook
FireWire I'm using. (Specifically in the EDID reading code.)

What would need to be done to get (and set?) the EDID parameters on a
Rage128 with an LCD panel to make lower-than-native resolutions work on
the display? Any pointers?

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
