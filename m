Content-Type: text/plain;
  charset="us-ascii"
From: Mark Chambers <markc@mail.com>
Reply-To: markc@mail.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: fec.c question
Date: Mon, 5 Aug 2002 09:45:29 -0400
MIME-Version: 1.0
Message-Id: <200208050945.29788.markc@mail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am porting Wolfgang's excellent package to our custom board.  Our board has
fec but not phy interrupt and I am having some problems with the driver not
recognizing when the link is up.  I see that there is a function in fec.c
(kernel 2.4.4) called mii_display_status() that would tell me the current
status, but I don't know how to get to it from the command line?

If anyone could point me in the right direction to learn how
mii_status_status(), and the other fec.c functions get called from the higher
levels it would be much appreciated as well.

Thanks,
Mark Chambers
Microfirst, Inc.
mchambers@microfirst.com or markc@mail.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
