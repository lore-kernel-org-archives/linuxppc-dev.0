Message-Id: <v03110700b3b1a7635364@[209.183.132.89]>
In-Reply-To: <Pine.LNX.4.10.9907111326260.392-100000@cassiopeia.home>
References: <14214.22225.201034.85545@cpu.wpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 13 Jul 1999 22:41:55 -0400
To: linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <kbhend@business.wm.edu>
Subject: Frame buffer on B+W G3 macs reports wrong display depth
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I really could use some help tracking down a problem.  From looking at
XF86Config and from running xdpyinfo, it seems the XF86 frame buffer server
reports incorrect bit depths which in turn are driving the JDK 1.2 swing
color model crazy!!!

For example, when I put my B+W into millions of color mode, xdpyinfo claims
32 bits for the depth (wrong it is 24, 8 bits for red, green, and blue),
and correctly claims 32 bits per pixel.

It has the same problem under 16 bit color, it claims a depth of 16 when in
reality the depth should be 15, 5 bits each for red, green, and blue
(although still using 16 bits per pixel).

I need to track this down and get it fixed asap to resolve the JDK 1.2
problems.  Note, that the Xpmac server correctly reports the bit depths and
it works fine with JDK 1.2 although it doesn't support the usb keyboard or
mouse correctly.

Does anyone have any ideas of where in all of the Xfree source code I
should begin looking?

Any guidance here would be greatly appreciated.

Thanks,

Kevin




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
