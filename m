Message-ID: <7283DE19D141D111AD0E00A0C95B195502D96922@mail2.aiinet.com>
From: "Dayton, Dean" <dean@aiinet.com>
To: "'Dan Malek'" <dan@netx4.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: fec on 8260
Date: Mon, 5 Jun 2000 17:28:33 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm using the MII interface on an EST SBC8260 board. I have a Canary
CTX-1170 100Base-TX transceiver that connects to the MII header.

===================================
Dean Dayton - dean@aiinet.com



-----Original Message-----
From: Dan Malek [mailto:dan@netx4.com]
Sent: Monday, June 05, 2000 4:45 PM
To: Dayton, Dean
Cc: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Re: fec on 8260


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
