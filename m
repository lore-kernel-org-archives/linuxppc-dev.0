Message-ID: <3B799A0A.497DFF56@mvista.com>
Date: Tue, 14 Aug 2001 14:37:14 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: James F Dougherty <jfd@GigabitNetworks.COM>, anj@aps.anl.gov,
	mporter@mvista.com, dan@mvista.com,
	linuxppc-embedded@lists.linuxppc.org, cort@cs.nmt.edu,
	jfd@cs.stanford.edu
Subject: Re: MPC8240 EPIC Driver (Attached)
References: <200108140743.AAA05509@krakatoa.gigabitnetworks.com> <3B7963C3.36191B14@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


James,

I took a look around and I think I deleted what I had.  It really wasn't that much
code anyway.  The important things are to get the functionality and not cause
wholesale changes to the existing code.

Please let me know if you're going to work on it and I'll wait to see what you come up
with.  Otherwise, now that there seems to be interest, I'll start working on it when
I'm done with my current project (in a few weeks).

Mark
--

"Mark A. Greer" wrote:

> James F Dougherty wrote:
>
> > Mark,
> >
> > Send me your changes and I'll
> > gladly test them...
>
> I never finished them.  I had some changes in an old 2.4.0-testxxx kernel but never
> finished what I started.
> This was several months ago so I kinda forget but I was going to make the
> initsenses table look something like what gets passed to openpic_initirq plus a
> field to specify the offset in from OpenPIC_addr/OpenPIC.  I also added a couple
> routines to set the epic in serial or direct mode and I think that was about it.
>
> I may have some of this laying around.  I'll take a look this afternoon & if its
> worth sending, I'll send it to you.
>
> Mark
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
