Date: Wed, 29 Aug 2001 22:29:01 +0100
Subject: Ethertalk routing problem
From: Iain Stevenson <iain@iainstevenson.com>
To: <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B7B31D2D.6BE%iain@iainstevenson.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been trying to get MacGate to work in order to enable a
LocalTalk/EtherTalk client to access my linux server.  I've most likely
overlooked something but maybe there's a more serious problem.

I've been using MacGate.  Within MacGate, a packet socket call is made:

SockLT = socket(AF_PACKET, SOCK_PACKET, htons(ETH_P_LOCALTALK));

followed by a call to receive traffic:

recvfrom(SockLT, buf, sizeof(buf)

However, no traffic is ever received.  Substituting the ETH_P_LOCALTALK with
ETH_P_ALL allows traffic through but none that subsequent code within
MacGate recognises as nbp.

Using tcpdump, I've found that traffic can be sent out of the linux server
through ipddp onto the Ethernet segment to which my Ethertalk client is
attached.

Using tcpdump I can also see MacIP traffic coming from the Ethertalk client.
However, none of this EtherTalk traffic gets through to the web server.
Maybe something isn't configured properly or I'm not understanding how
LocalTalk routing works.

I've searched many lists and tried many things ... but remain truly baffled.
Any suggestions?

  Iain Stevenson


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
