Message-ID: <392EA01D.CAC477EB@embeddededge.com>
Date: Fri, 26 May 2000 12:02:37 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Gessner, Matt" <mattg@aiinet.com>
CC: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: EST SBC8260 Question
References: <7283DE19D141D111AD0E00A0C95B195502581D59@mail2.aiinet.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Gessner, Matt" wrote:

> Can anyone who's using this board please shed some light
> on what's going on?

It depends upon the type of DIMM you are using.  Mine has the 2M x 64
DIMM, so it uses only /CS2 to get the 16 Mbyte space.  It also depends
upon the DRAM controller configuration.  Make sure you have the DRAM
controller properly configured to route the address lines.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
