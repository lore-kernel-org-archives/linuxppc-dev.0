Date: Tue, 30 Jan 2001 22:46:06 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
In-Reply-To: <20010130163538.A22219@allspice.cs.swarthmore.edu>
Message-ID: <Pine.LNX.4.10.10101302239070.27612-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > The big question: why does this particular command time out in the first
> > place? Does the target expect more data to be sent? Does the target just
> > crash and fails to release the bus? It seems to work on other host
> > adapters, doesn't it?
>
> There's a report of excatly the same failure mode on mac53c94 with a
> different brand (Sony, as opposed to Yamaha on my MESH) of DVD drive.

Please send a detailed description on how to reproduce this bug by PM.
I'll try to look into that on my Lombard, and in case I can get the
required binaries for m68k I'd also test on an old Quadra with 53c9x
SCSI.

Does the bug happen only with DVD writers, or regular CD writers?

> So the only points in common seem to be that the DVD drives are running
> on mac hardware and that the drivers are written by Paul Mackerras.  :-)
> I don't at all mean to impugn Paul's coding ability, which is obviously
> excellent, but the fact that he wrote both the drivers may mean that
> they share lots of code and possibly share the same bug.

If so, the bug should have propagated to the m68k 53c9x driver. Wouldn't
be the 53c9x first weirdness - I never got it to accept a DAT drive (old
DDS-1, possibly Apple) without blowing up.

It might be something PPC specific as well and have nothing to do with
Paul's drivers.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
