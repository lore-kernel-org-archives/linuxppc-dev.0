Message-ID: <39D7F8FB.9C508CF1@charter.net>
Date: Sun, 01 Oct 2000 21:54:51 -0500
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: ethernet on fads850sar board?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
this is a shot in the dark - but does anyone have
ethernet working on the fads850sar board, or any fads board?
Could I please see the code...  I'm working with the ppcboot
project, but can't seem to get this going on my fads board,
and don't really understand why.  The hub I'm connecting to
shows activity when I send a packet, but ethereal on my
also connected to the hub linux machine doesn't show anything
coming in.  After sending the packet, the status of the TxBD
is pretty much what I'd expect - 0x6c00.
Any ideas?
(And why do the baud rate generators that feed the ethernet
 clocks need to run at 2Mhz?)
	-Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
