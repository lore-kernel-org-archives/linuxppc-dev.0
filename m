Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: RE: EST SBC8260 and Canary CTX-1170
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Sun, 11 Mar 2001 07:28:27 -0600
Message-ID: <CD5CA14300A9D54A8D13D58CD3C87B422DD72B@advcorp-exc01.advent.com>
From: "Oliver Brown" <obrown@adventnetworks.com>
To: "Dan Malek" <dan@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The fcc driver that was working for ppcboot was in version 0.8.2,
however the 0.8.3 will have the fixes for the EST SBC8260.

The 2.4.1 kernel I am using came from kernel.org. I didn't realize that
there were updates in Bitkeeper tree. I'll try the latest Bitkeeper
kernel.

Regards,
Oliver

-----Original Message-----
From: Dan Malek [mailto:dan@mvista.com]
Sent: Thursday, March 08, 2001 6:36 PM
To: Oliver Brown
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EST SBC8260 and Canary CTX-1170


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
