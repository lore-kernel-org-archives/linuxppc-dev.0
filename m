Date: Sun, 4 Jun 2000 18:40:49 -0500
From: anthony tong <atong@uiuc.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: iMac sense codes & atyfb
Message-ID: <20000604184049.A780@rogue.genunix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I finally got curious enough (and finally had free time) to look
at the monitor sense values on an iMac (rev D I think)..

The iMac has a standard mac video connector mounted on the bottom
of the motherboard like contraption. Simply, the builtin monitor
doesn't return any Apple sense codes; unplugging the monitor gives
the same sense results. I suppose the iMac assumes that a monitor
is always attached. Connecting other monitors returns the proper
sense codes (well, I only tried a vga monitor.. it's a PITA with
the short cabling and that I don't have proper casing&ps for the
guts of this computer).

This brings up the question of why mac_map_monitor_sense() defaults
to 640x480x67 if no sense codes/no monitor is attached. The only
monitors that I can think of that use this mode are the old Apple
RGB monitors; perhaps we can use a more sensible default value instead
when using mac sense values?

If only we had ddc..

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
