Date: Fri, 11 Jul 2003 08:52:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ethernet PHY chip discovery not working on 855T with 971/972 chips
Message-ID: <20030711155226.GV17433@ip68-0-152-218.tc.ph.cox.net>
References: <20030711151834.GU17433@ip68-0-152-218.tc.ph.cox.net> <20030711154323.4B267C6D82@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030711154323.4B267C6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jul 11, 2003 at 05:43:18PM +0200, Wolfgang Denk wrote:
> Dear Tom,
>
> in message <20030711151834.GU17433@ip68-0-152-218.tc.ph.cox.net> you wrote:
> >
> > > We changed this in our kernel tree some time ago. If no valid PHY  is
> > > found  we simply do not enable the interface, but we do not panic any
> > > more.
> >
> > Which raises two fun questions:
> > 1) Do you plan on ever trying to re-sync your 2.4 tree with the
> > community tree (which should become kernel.org before too long)?
>
> We do this from time to time. The last  (visible)  re-sync  was  with
> 2.4.20  (ChangeSet  1.1174  =  20021129181904|49831), which is half a
> year ago. On the other hand, we don't have the  resources  to  follow
> each and every change immediately.
>
> > 2) Do you plan on trying to keep in sync with 2.6 now that it's coming
> > up on us?
>
> Of course we will follow 2.6 as well.
>
> Why are you asking? Did I give any reason to think we might go out of
> business?

No, but I do wonder if you ever plan on sending anything out again.  It
does seem to be a once a year event, which is just about due (2002-06-18
is the last one I see).

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
