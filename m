Message-ID: <004f01c442d3$c1d60d60$5500a8c0@davey>
From: "Davey" <daveywu@transengines.com>
To: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
Cc: <larryzheng@transengines.com>
References: <Pine.LNX.4.58.0405250909280.14496@localhost.localdomain> <20040525102352.A1329@home.com>
Subject: 405ep ether port broken in performance test.
Date: Wed, 26 May 2004 11:44:21 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am developing a firewall based on ibm405ep, it have 4 ether ports, two on-chip and two 8139c. And it run 2.4.18 MontaVista kernel.
Between two on-chip ports, one of a port will be broken after 0-2 seconds when I test the transaction rate with small packet (64 byte). and the port will return to fine 2-5minutes after the test end. When I use big packets, i works very fine. My tool is netiq chariot.

Between on-chip port and 8139c port, the result is fine.

Can anyone  give me some help?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
