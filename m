Date: Tue, 30 Jan 2001 16:35:38 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
Message-ID: <20010130163538.A22219@allspice.cs.swarthmore.edu>
References: <20010129182034.A25828@allspice.cs.swarthmore.edu> <Pine.LNX.4.10.10101302212490.27525-100000@zirkon.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10101302212490.27525-100000@zirkon.biophys.uni-duesseldorf.de>; from schmitz@zirkon.biophys.uni-duesseldorf.de on Tue, Jan 30, 2001 at 10:28:25PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 30, 2001 at 10:28:25PM +0100, Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de> wrote:
> The big question: why does this particular command time out in the first
> place? Does the target expect more data to be sent? Does the target just
> crash and fails to release the bus? It seems to work on other host
> adapters, doesn't it?

There's a report of excatly the same failure mode on mac53c94 with a
different brand (Sony, as opposed to Yamaha on my MESH) of DVD drive.
So the only points in common seem to be that the DVD drives are running
on mac hardware and that the drivers are written by Paul Mackerras.  :-)
I don't at all mean to impugn Paul's coding ability, which is obviously
excellent, but the fact that he wrote both the drivers may mean that
they share lots of code and possibly share the same bug.

-Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
