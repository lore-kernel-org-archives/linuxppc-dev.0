Date: Tue, 14 Aug 2001 23:27:45 -0700 (PDT)
From: James F Dougherty <jfd@GigabitNetworks.COM>
Message-Id: <200108150627.XAA06862@krakatoa.gigabitnetworks.com>
To: mgreer@mvista.com, dan@mvista.com
Subject: Re: MPC8240 EPIC Driver (Attached)
Cc: jfd@GigabitNetworks.COM, anj@aps.anl.gov, mporter@mvista.com,
	linuxppc-embedded@lists.linuxppc.org, cort@cs.nmt.edu,
	jfd@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Very cool! My MPC8240 board is off for PCI rework, when I get it
back, I will try it out (PCI slot problems with Promise PDC20262).


More later ...

				-James

>
> "Mark A. Greer" wrote:
>
> > I took a look around and I think I deleted what I had.....
>
> Attached is a patch that works with Sandpoint X3, adds the new
> serial mode interrupt stuff, and 8245.  You may have to manually
> apply it, but it gets you started.
>
> It's on my check-in list, but I have higher priority things at
> the moment.  Like Mark said, I would like to see a better OpenPIC
> solution that could also include EPIC and be a little more configurable.
> I was hoping this would have happened by now, as I would have rather
> added to that instead of propagating more hacks.
>
>
> 	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
