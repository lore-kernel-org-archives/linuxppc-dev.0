Date: Tue, 26 Oct 1999 13:38:54 +0200 (CEST)
From: Michael Schmitz <schmitz@amber.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: chris mccraw <chrism@brahma.ticam.utexas.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: IR on lombard?
In-Reply-To: <19991026112903.024351@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.9910261337350.27302-100000@amber.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> >this functionality seems to have been present or at least touched on for
> >the wallstreet powerbooks judging from the code in
> >	drivers/macintosh/macserial.c
> >but my (weak) attempts to force the second serial port into the role of
> >wallstreet powerbook_ir seem to have failed.
> 
> On my wallstreet, ttyS1 is automatically recognized as an IR port, isn't
> this the case on your machine ? In this case, I'm interested in a dump of
> the device tree portion that contains the escc nodes on your machine.

ttyS1 isn't recognized as IR port on my lombard. How do I dump the device
tree? 

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
