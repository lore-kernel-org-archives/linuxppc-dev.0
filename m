Message-Id: <200010121341.IAA20116@lists.linuxppc.org>
From: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>
Reply-To: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
Cc: Josh Huber <huber@mclx.com>,
        Linux/PowerPC Devel List
	 <linuxppc-dev@lists.linuxppc.org>
Date: Thu, 12 Oct 2000 09:41:22 -0400
Content-Type: text/plain;
	charset=us-ascii
Subject: Re: dual head r128
Mime-Version: 1.0 (Apple Message framework v337)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> the patch breaks the calculations for the x86 cards
> (thats the reason why its not in the xfree cvs), so don't expect to get
> sane values for the x86 card. (aty128fb has the same problem as well btw)

Why?  This should not be unless the bios on the x86 card never initializes the card in any way.  If the bios does do some basic initialization, the patch should work just as well for an x86 card as a ppc one if the main clock rate is the same.  If the main clock rate is different, as long as you can find out what it is, reading and calculating the  timings from those register settings really should work generically, shouldn't it?

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
