Date: Wed, 17 Feb 1999 17:44:31 -0600 (CST)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Bill Davidsen <davidsen@prodigy.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [ppc-dev] Re: Restructuring Efforts
In-Reply-To: <19990217182716.027588@mail.mipsys.com>
Message-ID: <Pine.LNX.3.96.990217172825.19695C-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 17 Feb 1999, Benjamin Herrenschmidt wrote:

> I like the function pointers idea but I don't like indexing by machines
> each time the table is accessed. I beleive we should define a structure
> of function pointers for each subsystem (setup, mm, irq, ...) at have
> some boot logic fill the kernel static tables with pointers from the
> subsystem exported tables. The decision based on the architecure must be
> done only once.

Sounds a lot like a bunch of things in BSD-like kernels, where, in
MkLinux, for instance, interrupt_heathrow.c, interrupt_pdm.c, etc. each
have a static structure with pointers to their externally visible
functions, and the main function checks the hardware type and assigns a
global pointer to point to the static structure for the particular set of
routines.  Is that what you mean?


Later,
David

David A. Gatwood                         Visit globegate's internet
dgatwood@globegate.utm.edu                  talker, Deep Space 36
http://globegate.utm.edu                telnet globegate.utm.edu:9624


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
