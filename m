Message-ID: <3AA82575.D6C1CAF2@mvista.com>
Date: Thu, 08 Mar 2001 19:36:05 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Oliver Brown <obrown@adventnetworks.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EST SBC8260 and Canary CTX-1170
References: <CD5CA14300A9D54A8D13D58CD3C87B422DD729@advcorp-exc01.advent.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Oliver Brown wrote:

> I can't generate any traffic on the fast ethernet port.

The CTX-1170 worked at one time on the EST board.  Unfortunately,
I had to make little changes for just about every different 8260
board I have seen.  Further, my EST boards have all failed in some
way or another so I can't even test this anymore.

Even when it "worked", I had trouble with some 10/100 switches.

> Ppcboot works fine on this setup, so I know that the hardware is
> working.

Is this driver available from sourceforge, or is it something you have
locally?  I would like to look at it and I may see some differences.

Most of the changes surround the MDIO interface and the software
"clocking" of the bits on those lines.  The PHYs seem sensitive to
timing I just can't get right with the software.  I was able to get
one, or a small subset, working at the same time, but not all of them
at once.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
