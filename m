Message-ID: <032e01c0d73f$58022160$4b00000a@foolio1>
From: "Eli Chen" <eli@routefree.com>
To: "Dan Malek" <dan@mvista.com>
Cc: <brian.kuschak@skystream.com>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <027b01c0d728$9a702b80$4b00000a@foolio1> <3AF710DC.37209810@mvista.com>
Subject: Re: dcache BUG()
Date: Mon, 7 May 2001 14:47:42 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> What version of silicon do you have, and what platform are you using?

I am using the 405GP core, rev D.  My tree is based off of the February 26th
source from MontaVista.

> Is there some simple test I can use to trigger this problem?

Besides Brian's one-liner test, you can try flood pinging your 405GP.  I
have been consistently receiving these error messages after letting it run a
while:

Freeing alive device (cxxxxxxx), ethx

and

Attempt to release alive inet socket cxxxxxxx

I have also occasionaly received other messages, which I have yet to receive
after changing atomic.h.

Eli


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
