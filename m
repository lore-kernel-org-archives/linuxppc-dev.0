Message-ID: <3B7963C3.36191B14@mvista.com>
Date: Tue, 14 Aug 2001 10:45:39 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: James F Dougherty <jfd@GigabitNetworks.COM>
Cc: anj@aps.anl.gov, mporter@mvista.com, dan@mvista.com,
	linuxppc-embedded@lists.linuxppc.org, cort@cs.nmt.edu,
	jfd@cs.stanford.edu
Subject: Re: MPC8240 EPIC Driver (Attached)
References: <200108140743.AAA05509@krakatoa.gigabitnetworks.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


James F Dougherty wrote:

> Mark,
>
> Send me your changes and I'll
> gladly test them...

I never finished them.  I had some changes in an old 2.4.0-testxxx kernel but never
finished what I started.
This was several months ago so I kinda forget but I was going to make the
initsenses table look something like what gets passed to openpic_initirq plus a
field to specify the offset in from OpenPIC_addr/OpenPIC.  I also added a couple
routines to set the epic in serial or direct mode and I think that was about it.

I may have some of this laying around.  I'll take a look this afternoon & if its
worth sending, I'll send it to you.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
