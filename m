From: "Frank Smith" <smith@amirix.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: "Frank Smith" <smith@amirix.com>
Subject: FEC and ETH on EP860
Date: Fri, 11 Jul 2003 19:02:05 -0300
Message-Id: <03Jul11.185300adt.7313@dragon.appliedmicro.ns.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Is anyone aware of any issues involving use of the FEC and ETH
at the same time on an Embedded Planet EP860 running Linux?

If I bring the board up with Planet Core thinking DefaultENET=FENET,
I can boot Linux, and both Ethernets work.  If I bring the board up
with DefaultENET=ENET, the ETH works, but the FEC doesn't.  The FEC
driver attaches OK, but when I go to send some traffic out the FEC,
I get ring buffer dumps because packets aren't being transmitted.
CONFIG_USE_MDIO is not set in my configuration.

I'm using a 2.4.18 kernel (design constraint).  I'm just beginning
to dig into the details of this problem so I don't have much more
in the way of specifics to report yet.  Has anybody encountered the
same problem?


Thanks,
-Frank.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
