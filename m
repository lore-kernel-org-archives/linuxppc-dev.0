MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Anyone got eepro100 working on Walnut?
Date: Tue, 16 Apr 2002 21:08:41 -0400
Message-ID: <FF6CF34C346E724596A2FB5CAAB2C4978844FF@voyager.ops.infiniswitch.com>
From: "Wright, David" <dwright@infiniswitch.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've been trying to get an Intel eepro100 card working on a
Walnut board.  I've tried both the 1.09 and 1.19 versions of
the driver (eepro100.c).  Initially, both failed the self-
test step.  I was able to get past that one by invalidating
the dcache after issuing the self-test directive.  However,
I now find that the card is neither transmitting nor receiving
reliably.  I get messages like:

   eth1: Unknown receiver error, status=0x5048.  [lots of these]

and

eth1: Transmit timed out: status 0050  0000 at 2/8 commands 00a00300 00a003000.
eth1: Restarting the chip...
eth1: Command unit failed to mark command 00030000 as complete at 6.


Any suggestions (other than junking this card, which is not an option
for me) most welcome.

  -- David Wright, InfiniSwitch Corp.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
