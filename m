Message-ID: <7283DE19D141D111AD0E00A0C95B195502581D59@mail2.aiinet.com>
From: "Gessner, Matt" <mattg@aiinet.com>
To: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: EST SBC8260 Question
Date: Fri, 26 May 2000 08:54:02 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings,

I'm trying to access the upper 8MB of the 16MB SDRAM.
But it's not working.

On mine, and I'm sure most others, it's tied to /CS2 and /CS3.
But the example BSP I have from EST doesn't set up /CS3.

Can anyone who's using this board please shed some light
on what's going on?

/CS2 is setup to use 16MB.

TIA

Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
