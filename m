Date: Tue, 6 Feb 2001 13:27:35 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Iain Sandoe <iain@sandoe.co.uk>, Takashi Oe <toe@unlserve.unl.edu>,
        bob@kunk.jriver.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: SOLVED: mesh SCSI bus locks hard on 7500 when burning a CD-R in
Message-ID: <20010206132735.A4698@allspice.cs.swarthmore.edu>
References: <20010206073853.6DE76DBA0E@atlas.valhalla.net> <Pine.LNX.4.30.0102061347320.14864-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.30.0102061347320.14864-100000@opal.biophys.uni-duesseldorf.de>; from schmitz@opal.biophys.uni-duesseldorf.de on Tue, Feb 06, 2001 at 06:41:52PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 06, 2001 at 06:41:52PM +0100, Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de> wrote:
>
> > > 7100.  G3 desktop comes with mesh.
>
> Too bad. I don't think I have space for yet another kernel tree on my
> Lombard, or the stomach to get involved with the Nubus kernel.
>
> > I have 9600 with both MESH & 53C94 - both have devices - and my CD-RW is on
> > that machine (not tried under linux yet).
> >
> > So, time willing, I'm happy to test things.
>
> I'll try to cook up someting reasonably safe...

The patch I sent should fix the immediate problem with burning CD's in
disk-at-once mode.  It works for me.  But clearly there's room for SCSI
improvements so that this doesn't happen again with other new commands.

-Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
