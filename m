From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: 7450 L3 undocumented register
Date: Sun, 17 Feb 2002 13:49:01 +0100
Message-Id: <20020217124901.10737@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

I'm working on L3 setup/enable code for the 745x CPUs (in order to properly
configure the second CPU L3 of Apple's Dual G4s). I've studied Apple's darwin
code and it makes use of a register that isn't documented in the 7450UM rev.2
It's SPR 984, called L3PEDT.

Anybody has a clue about it ? I also noticed that their
flush/disable/invalidate/enable sequence is a bit different that what is
documented in the above manual, they additionally tweak the MSSSR0 L3TAG
bit (possibly to clear a transcient error) and they set both L3CR data only
and instruction only bits.

So anybody has a clue about what should actually be done ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
