Message-Id: <200011291700.eATH0Dp20788@denx.local.net>
To: Rolf.Fiedler@Ferrari.DE
cc: linuxppc-embedded@lists.linuxppc.org, Ruedi Dummermuth <ruedi@abatron.ch>
Subject: Re: target entered debug mode 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 29 Nov 2000 16:20:08 +0100."
             <3A251EA8.74A26893@Ferrari.DE>
Date: Wed, 29 Nov 2000 18:00:13 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3A251EA8.74A26893@Ferrari.DE> you wrote:
>
> I have a monta vista 2.4.0-test1 kernel running on a IBM PPC405GP
> selfmade board. Connected to the board is an Abatron BDI2000, which
> I use for TFTP booting. The board mounts the root nfs via PMC ethernet
> (intel i82559ER). The internal ethernet controller isn't working,
> I have no idea why - can't talk to the LXT972 via MII management
> interface. That is my next task...

I had similar problems with the FEC driver on a MPC860T; it was "just
broken" (tried to read the MII data register without enabling the FEC
controller at all).

> How come the board enters debug mode on the Abatron BDI2000 once
> in a while? I had it running processing data all over the weekend,
> and on monday it locked. I had a number of lock-ups since.

I'm not sure about the 405, but probably  it  has  something  like  a
Debug  Event  Register  too,  which might be configured wrong for use
under Linux.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Some programming languages manage to  absorb  change,  but  withstand
progress.          -- Epigrams in Programming, ACM SIGPLAN Sept. 1982

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
