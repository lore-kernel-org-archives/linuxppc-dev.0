Subject: Re: BriQ & Linux 2.6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jamie Heilman <jamie@audible.transient.net>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040521233523.GJ8520@audible.transient.net>
References: <20040521074018.GD8520@audible.transient.net>
	 <1085181034.6755.7.camel@gaston>
	 <20040521233523.GJ8520@audible.transient.net>
Content-Type: text/plain
Message-Id: <1085199239.9230.4.camel@gaston>
Mime-Version: 1.0
Date: Sat, 22 May 2004 14:14:00 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2004-05-22 at 09:35, Jamie Heilman wrote:
> Benjamin Herrenschmidt wrote:
> > I have a few patches for the briq, I didn't push them upstream yet,
> > as I'm trying to find a clean way to deal with an issue relative
> > to the serial port clock setting.
>
> What is that issue out of curriosity?  I ask because... well I've had
> some rather incongruous experinences with serial on the BriQ compared
> to what Karsten at Total Impact was telling me I should be having.

Well... the base clock isn't what the driver thinks, so it must be
hacked. But the driver doesn't provide a clean way to set another
base clock, I'm trying to find something better than what the hack
in the patch does.

> Basically, all the kernels they've shipped recently had code that did
> some funky stuff to the baud rate.  On my briq that made the serial
> port spew total garbage during boot until init hits runlevel 2 and
> resets it (debian), then everything is OK again.  After reverting their
> changes everything works again.  So I'm afraid I've had to take their
> code with a grain of salt.  ISTR they were multiplying something by 4
> that I found was better left alone... but I'd have to go back and see
> if I could find my old source trees to be sure, last time I looked at
> this box was 2 years ago.
>
> > Enclosed is my latest version of that patch (may need some hand-applying
> > as it's a couple of monthes old).
>
> Thanks!  I'll play with it.
>
> --
> Jamie Heilman                     http://audible.transient.net/~jamie/
> "I was in love once -- a Sinclair ZX-81.  People said, "No, Holly,
>  she's not for you." She was cheap, she was stupid and she wouldn't
>  load -- well, not for me, anyway."                     -Holly
>
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
