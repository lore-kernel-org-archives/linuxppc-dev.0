Message-ID: <393C1149.E24765F0@embeddededge.com>
Date: Mon, 05 Jun 2000 16:44:57 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Dayton, Dean" <dean@aiinet.com>
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: fec on 8260
References: <7283DE19D141D111AD0E00A0C95B195502D96921@mail2.aiinet.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Dayton, Dean" wrote:

> I'm assuming that it wouldn't be a huge undertaking to port the 860 FEC
> driver, but if someone has already done it ...;-)

I'm working on the FCC driver right now.  I made a huge change to the
8xx FEC driver to generically support different PHYs, so I thought I
would get that one working again and then use it as a baseline for the
8260 FCC.  Of course, this also means I have to make 2.4.xx work
correctly on the 8xx so I can test it.  I may just bail on that and
get the more simple FCC driver running.  What PHYs are people using?

I'll post a message as soon as I get something close to working.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
