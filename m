Mime-Version: 1.0
Message-Id: <a04310102b8e086debdbe@[199.170.89.178]>
In-Reply-To: <20020415074341.4272.qmail@web11003.mail.yahoo.com>
References: <20020415074341.4272.qmail@web11003.mail.yahoo.com>
Date: Mon, 15 Apr 2002 08:38:26 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Jeff Walther <trag@io.com>
Subject: Re: 9600 maturity?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 00:43 -0700 04/15/2002, Dan Bethe wrote:

>Hi all.  I am considering getting a Powermac 9600 with a single 200
>MHz 604e to
>replace my 8500 as a production server.  I can't find any info so far on the
>maturity of Linux's support of the 9600.

If Linux support for PCI-PCI Bridges is acceptable (I have no idea
myself) you might consider the Umax S900.  It has six PCI slots, but
four of them are behind a PCI-PCI Bridge built into the motherboard.
The advantage of the S900 is that the architecture is basically that
of an 8500/7500.

Architecturally, the x500 machines are all very similar.   The 9500
has two Bandit chips on the CPU/memory bus instead of one, and that
can create CPU bus arbitration problems.  The 7500/8500 has only one
Bandit chip, but they add a CHAOS video bridge chip to the CPU bus.
The S900 has no CHAOS and only one Bandit.  Then it sacrifices its
third PCI slot in order to connect the upstream side of a DEC 21052
PCI-PCI Bridge and hangs four more PCI slots off of the PPB.

I have found that any PCI card which has its own PPB hangs the
machine (with a few exceptions) in the lower four slots.  i.e. if you
create a hierarchy of two PPBs Apple's PCI implementation bails.

Jeff Walther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
