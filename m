Date: Tue, 6 Feb 2001 22:01:55 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Iain Sandoe <iain@sandoe.co.uk>, Takashi Oe <toe@unlserve.unl.edu>,
        bob@kunk.jriver.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: SOLVED: mesh SCSI bus locks hard on 7500 when burning a CD-R in
In-Reply-To: <20010206132735.A4698@allspice.cs.swarthmore.edu>
Message-ID: <Pine.LNX.4.10.10102061940080.21813-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >
> > I'll try to cook up someting reasonably safe...
>
> The patch I sent should fix the immediate problem with burning CD's in
> disk-at-once mode.  It works for me.  But clearly there's room for SCSI

I understood that :-)

> improvements so that this doesn't happen again with other new commands.

It's more about adding disconnect support to the 53C94 PPC driver at the
moment. I'm not touching MESH 'cause I've got no experience with that
code, and no specs. I'm a bit familiar with the 53C9x series chips in the
old Macs.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
