Date: Tue, 18 Dec 2001 01:15:42 -0300
From: Ricardo Scop <scop@vanet.com.br>
Reply-To: scop@vanet.com.br
Message-ID: <1052.011218@vanet.com.br>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Synchronous (HDLC) driver for MPC82xx SCC and kernel 2.4.x
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm in the process of adapting an SCC HDLC driver for the Motorola
MPC8260 CPM. I'm aware of SNMC's Daris Nevil hdlc_ppp driver for the
8xx SCC, which works on Linux 2.2.x version, but I decided to start
from 8260 Dan Malek's scc_enet driver as a framework (which works on
2.4.x Linux version, and works very fast), and use the former as a
guideline.

In it's final shape, the driver will attach to the generic hdlc driver
available at the current kernel source tree, with support for PPP,
Cisco HDLC, raw HDLC, Frame Relay and X.25 WAN protocols. Plus, it
should be fast enough to handle 4 SCCs at a high rate aggregate (maybe
8 Mbps or more... the sky is the limit).

What I would like to know is:

- Is my approach a good one? (IMHO, yes :-))

- Should I take the risk of not having an interrupt routine's bottom
half, as in the SCC ethernet driver?

- Are there any other 8xx/82xx SCC synchronous driver implementations
other then the above mentioned?

I would be very glad to share my present (and future) knowledge and
experience with those working on this subject.

Thanks in advance for any suggestions/pointers...

Ricardo Scop                          mailto:scop@vanet.com.br
R SCOP Consult.
-------------------------------------------------------------
"Don't hate, it's too big a burden to bear."
~Martin Luther King Jr.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
