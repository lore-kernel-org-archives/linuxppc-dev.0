Message-ID: <3B703ADA.9ADAFBAD@carts.com>
Date: Tue, 07 Aug 2001 12:00:43 -0700
From: Kevin Fry <kevin@carts.com>
MIME-Version: 1.0
To: linuxppc emb3dd3d list <linuxppc-embedded@lists.linuxppc.org>
Subject: Strange bootpd behavior (server side)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm having a small problem with our redhat 6.2 bootp server and maybe
yous guys can shed some light on it for me.   The problem is that
whenever our DSL internet connection is down(which is too much.. I wish
cable was available!), the bootpd stops responding to requests.. I can
see the requests with tcpdump, but no replys. and when the internet is
up sometimes is takes a little bit for the bootpd to respond to
requests.
    I think it's doing DNS resolution and if it can't find a DNS server
when the net's down, it just stops working. Does linux automatically do
name resolution on every address it gets? If so can i turn this off?
    Our network is behind a DSL modem/router (Flowpoint 2200) acting as
gateway(192.168.254.254), and we have 3 switches after that.
    A lot of the time the router is finicky with linux even when
everything is working.. I know this is a bit off topic, but ANY
suggestions are very welcome.

Here's my routing table..

Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use
Iface
192.168.254.13 *                   255.255.255.255 UH    0      0
0 eth0
192.168.254.0   *                   255.255.255.0   U     0
0        0 eth0
127.0.0.0       *                       255.0.0.0       U     0
0        0 lo
default    192.168.254.254    0.0.0.0         UG    0      0        0
eth0

Thanks!
Kevin Fry


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
