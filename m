Date: Tue, 27 Nov 2001 13:50:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Please make K2 Linux bootable without PeeMON again
Message-ID: <20011127135058.O13091@cpe-24-221-152-185.az.sprintbbd.net>
References: <0111272040.AA24978@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0111272040.AA24978@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 27, 2001 at 12:40:45PM -0800, Michael Sokolov wrote:
> Tom Rini <trini@kernel.crashing.org> wrote:
> > I've been thinking, and one of two things could happen, at least in the
> > wrapper, we know mem size (Firmware, res data, magic).  Or assume
> > there's at least XX megs of ram on the system (I _think_ 16mb is the
> > 'normal' min, but of course we have lots of systems breaking that rule).
> >
> > What I'd like to see, and at least I think would be a good thing to
> > figure out is a general 'safe' location to store these in.
>
> Again, all this strikes me as unnecessary trouble. Just have the bootloader
> tell the kernel where the bi_recs are!

Right.  I think I confused you somewhere along the line.  I want the
kernel to be told the bi_recs are <someplace>.  I just want to get what
people think would be a good rule-of-thumb <someplace>.  I take it you
belive 8mb and change is a good rule-of-thumb location, yes?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
