Message-Id: <v03110700b4f2ab8adc01@[129.100.29.243]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 13 Mar 2000 09:45:43 -0500
To: linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Here are some Rage128Pro video timing info from Mac Side
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Just in case these might be of some value to others.  I have used the
DeviceNameRegistry program under MacOS and have collected the following
timing info for my G4 450 which has a Rage128Pro PF card installed:

In all cases, the color depth was set to millions of colors:

(all values are in hexadecimal/decimal)

           	1280x1024-75	1152x870-75	1024x768-85	832x624-75
		------------	-----------	-----------	----------
XCLK		0x36d5/14037	0x36d5/14037	0x36d5/14037	0x36d5/14037

MCLK		0x2e18/11800	0x2e18/11800	0x2e18/11800	0x2e18/11800

VCLK		0x34bc/13500	0x2710/10000	0x24ea/9450	0x165d/5725

REF		0x0b86/2950	0x0b86/2950	0x0b86/2950	0x0b86/2950

DotClock	0x34bc/13500	0x2710/10000	0x24ea/9450	0x165d/5725


And in all cass the AAPL,addresses for the card were:

94000000
90020000
90000000

So with this info, I will modify aty128fb.c to use these values if it
identifies the chip as a Rage128Pro RF (0x5046).

Hopefully this will help fix the split panes issues.

If anyone wants/needs more info from the MacOS device registry on any of
the items in the tree, just ask.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
