To: linuxppc-embedded@lists.linuxppc.org
Subject: PowerPC 440GP-specific optimization with gcc
From: Roland Dreier <roland@digitalvampire.org>
Date: 21 Feb 2003 19:30:47 -0800
Message-ID: <87ptplyot4.fsf@love-shack.home.digitalvampire.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We have a PowerPC 440GP-based design running Linux.  Right now our
kernel and applications are built with gcc for a "405" target
(essentially by using the -m405 flag).

This works fine, and all of our executables run with no problem.
However, we are interested in optimizing specifically for the 440.  As
far as I can tell, neither gcc 2.95 nor gcc 3.2.2 have any support for
this.

Is anyone aware of any work in this direction?

Thanks,
  Roland
--
Roland Dreier  <roland@digitalvampire.org>  GPG Key: 1024D/E0EEFAC0
Fingerprint:     A89F B5E9 C185 F34D BD50  4009 37E2 25CC E0EE FAC0

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
