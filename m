To: Tom Rini <trini@kernel.crashing.org>
Cc: "Mark A. Greer" <mgreer@mvista.com>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 19 Mar 2002 17:05:00 MST."
             <20020320000500.GV3762@opus.bloom.county>
Date: Wed, 20 Mar 2002 01:28:12 +0100
Message-Id: <20020320002817.6B2F3109F3@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20020320000500.GV3762@opus.bloom.county> you wrote:
>
> > > need to change the driver to handle multiple enets, yes?
> >
> > Only some, like the 8xx. Other  configurations  run  just  fine  with
> > several ethernet interfaces.
>
> Well yes, but the ones which run fine with several ethernet interfaces
> are a) generic drivers (tulip, eepro, et al) and b) just work right now
> with multiple devices, and I'm not sure why they'd want to care about
> bi_recs.

Take the 8260 for an example - it is not a generic driver, and  there
is no existing solution to pass more than one MAC address.

> Me.  But it's gotta be made to work sometime.  And as a bonus, Linus is
> away for 2 weeks so things probably won't get worse than they are right
> now for about 2 weeks. :)

This is not the way I want to work.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The human mind  ordinarily  operates  at  only  ten  percent  of  its
capacity. The rest is overhead for the operating system.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
