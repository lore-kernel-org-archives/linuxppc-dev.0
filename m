Subject: 2.6.6 kernel oops on ifconfig eth0 mtu 1300
From: Soeren Sonnenburg <kernel@nn7.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1084643442.4708.3.camel@localhost>
Mime-Version: 1.0
Date: Sat, 15 May 2004 19:50:42 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi.

When I have some ethernet connection and then do
ifconfig eth0 mtu 1300 I get an immediate kernel panic (kernel 2.6.6)
powerbook g4 15" 1ghz.

(xmon trace (jpeg) on request)

Ideas ?
Soeren


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
