To: boehringer@snom.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem booting Linux on MPC8XXFADS 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 26 Mar 2002 09:41:27 +0100."
             <3CA03437.5E724251@snom.de>
Date: Tue, 26 Mar 2002 09:55:28 +0100
Message-Id: <20020326085533.96CE7109F3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3CA03437.5E724251@snom.de> you wrote:
>
> > Check that you have configured the console on the correct  port;  you
> > should be able to get a good configuration with
> >
> >         $ make FADS860_config
> >         $ make oldconfig
> >         $ make dep
> >         $ make pImage
>
> Thanks for that hint. With your sources (linux-2.4.4-2002-03-21.tar.bz2)
> and the configuration it works! Now i try to port that to 2.4.17

Fine.

> (possible? :-).

Better use 2_4_devel ...

> > But you should be aware - your chances to succesfully run Linux on  a
> > FADS rev ENG or PILOT board are pretty limted anyway.
>
> What exactly do you mean with "be aware of"? Are there any common
> failures with that board? Unfortunately, i have to use this Board :-(

The  (F)ADS8xx  is  (in)famous.  Maybe  it  was  sponsered   by   the
unemployment  office  to keep all these programmers busy, hunting for
software problems for weeks and weeks and weeks (util  they  realized
they had hardware problems).

You don't have to use this board.

There are alternative solutions. Just divide the  price  for  another
board  (stable  hardware with full Linux support) by your hourly rate
and you probably already now wasted money on the FADS...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
No journaling file system can recover your data if the disk dies.
                                 - Steve Rago in <D4Cw1p.L9E@plc.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
