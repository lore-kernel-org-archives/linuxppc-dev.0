Subject: Ethernet on 8260
From: Brad Bonkoski <bradb59@home.com>
To: ppc-embed <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Date: 16 Jul 2001 17:19:36 -0700
Mime-Version: 1.0
Message-Id: <20010717002518.YUJE5550.femail18.sdc1.sfba.home.com@cx263713-b.mesa1.az.home.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am working with a custom 8260 board which has 3 Ethernet devices that
are on using FCC to communicate.  When I try to activate all three I get
some funny routing.  Essentailly, I have them all set up on the same
network: 192.168.0.X.  When I try to ping one Ethernet device, the
system tries to respond on another.  What could lead to this problem?
The CPM appears to be placing the sk_buffs in the right queues in DPRAM,
but the sk_buffs seem to be getting mangled, many times the kernel tries
to shove an additional ARP header on them.  Any ideas as to what could
be causing this?  Is this a known problem and fixed in later versions of
fcc_enet.c?  Do I need to post additional diagonostic information?
Thanks for any help.
-Brad


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
