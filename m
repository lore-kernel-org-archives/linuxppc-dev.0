To: "Banks, Kelly" <kelly.banks@gilbarco.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC860 onchip WatchDog 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 06 Mar 2002 17:01:30 EST."
             <A3E34B558F5CD211B4980008C7A4A9900242418D@sparrow.gso.mcs.marconi.com>
Date: Wed, 06 Mar 2002 23:22:22 +0100
Message-Id: <20020306222227.84168109EB@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <A3E34B558F5CD211B4980008C7A4A9900242418D@sparrow.gso.mcs.marconi.com> you wrote:
>
> I just did this last week.  My test load is cooking in the test oven now.
> You need to tickle the WD at several places within the kernel.  For me, it

Depends on what you want to do. Normally it's sufficient to make sure
one top-level application process is  running,  so  a  normal  device
driver  is sufficient - see for instance drivers/char/wdt_mpc8xx.c in
our kernel source tree.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There are two ways of constructing a software design. One way  is  to
make  it  so  simple that there are obviously no deficiencies and the
other is to make it so complicated that there are  no  obvious  defi-
ciencies.                             - Charles Anthony Richard Hoare

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
