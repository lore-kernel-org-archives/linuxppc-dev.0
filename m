To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 19 Mar 2002 18:00:17 EST."
             <3C97C301.B5A95C8B@mvista.com>
Date: Wed, 20 Mar 2002 08:55:36 +0100
Message-Id: <20020320075541.1A5DE109F3@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <3C97C301.B5A95C8B@mvista.com> you wrote:
>
>
> The BI_ETH_CFG has already been shot down so we don't need to worry about it
> anyway.

Has been shot down? When? Where? Why? Am I missing something?

So how are we going to solve this issue - in 2.4 and 2.5?

We need to deal with boards with more than  one  ethernet  interface,
which  are already active in the firmware (net-booting from redundand
interfaces, using separate MAC addresses).

> > Ethernet driver, or where? How do you make sure that each Ethernet interface
> > gets the MAC address that belongs to it?

We added an index field to BI_ETH_CFG, didn't we?  The  driver  would
then "know" how to map this...

> This is a good point and this is an issue with any generic ethernet bi_rec
> scheme.  At this point, I'm back to preferring what you've done since...well...its
> done and I don't see anyone else caring much about this for other drivers.

We _do_ care, a little for 8xx, very much for 8260, also for 824x and
4xx.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Fools ignore complexity. Pragmatists suffer it. Some  can  avoid  it.
Geniuses remove it.
- Perlis's Programming Proverb #58, SIGPLAN Notices, Sept.  1982

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
