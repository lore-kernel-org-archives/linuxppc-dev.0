Date: Wed, 15 Dec 1999 09:53:58 -0700 (MST)
From: Stephen Edie <sedie@terraplex.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCNET32 driver
In-Reply-To: <19991215174442.007768@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.9912150949200.27113-100000@newhope.terraplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ben,

These problems show up on both our IBM RS/6000 F50 and IBM RS/6000 B50.
In the case of the F50, the problem is apparent on the add-in card.  (I
believe the built in Ethernet only supports 10mbit)  It doesn't happen in
10mbit mode, however... only 100mbit.

Unfortunately, I have never worked with an Ethernet driver so I have no
idea where to start playing with parameters.  :)

Stephen

Terra Soft Solutions, Inc.
   Yellow Dog Linux
   "The Ultimate Companion for a Dedicated Server"
   http://www.yellowdoglinux.com/


On Wed, 15 Dec 1999, Benjamin Herrenschmidt wrote:

> On Wed, Dec 15, 1999, Stephen Edie <sedie@terraplex.com> wrote:
> 
> >When running in 100mbit mode, the PCNET32 driver reports the following
> >error message:
> >
> >eth0:TX FIFO error! Status 02e3
> >
> >With this messages present, we have seen a number of problems from
> >TCP connections being closed after a few bytes of transfer to very poor
> >performance (1-mbit throughput) to not working at all.  Is there a quick
> >way to fix this problem perhaps?  We would like to get some of our
> >in-house CHRP machines running at the full 100mbit and we have some
> >customers who require 100mbit throughput as well.
> 
> Which pcnet32 chip are you using ? There are some issues with
> auto-negociation on some integreated-PHY models, and you may have to
> adjust a few of the chip parameters. I used the pcnet32 driver with an
> AMD 973 on an ARM platform and it worked just fine (after I fixed the
> cache coherency issues but those won't happen on PPC).
> 
> 
> 


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
