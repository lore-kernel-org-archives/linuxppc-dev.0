Message-Id: <5.1.0.14.2.20030418195912.02dcf908@mail.ebshome.net>
Date: Fri, 18 Apr 2003 20:05:29 -0700
To: Tom Rini <trini@kernel.crashing.org>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: [PATCH] Fix prep boot in linuxppc_2_4_devel
Cc: Cort Dougan <cort@fsmlabs.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030419023238.GA8542@ip68-0-152-218.tc.ph.cox.net>
References: <20030418210231.GB7065@ip68-0-152-218.tc.ph.cox.net>
 <20030416173830.GM20197@host109.fsmlabs.com>
 <20030418210231.GB7065@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 07:32 PM 4/18/2003, Tom Rini wrote:

>On Fri, Apr 18, 2003 at 02:02:31PM -0700, Tom Rini wrote:
>
> > On Wed, Apr 16, 2003 at 11:38:30AM -0600, Cort Dougan wrote:
> >
> > > This fixes the prep boot code so it will actually create a good SMP boot
> > > image.  The wrong variable was being used.
> >
> > Urk.  Can we kill znetboot / znetboot.initrd instead please?
>
>Or, for the potentially silent masses of you out there who do use this,
>please speak up.  I'm not really aware of anyone other than Cort who
>does use this target but am more than willing to stand corrected.

I found this target convenient and I use it on daily basis.

I understand that it's a little ugly and referencing some
external hardcoded paths like /tftpboot from makefile is not a
very Good Thing :).

So I would not complain *very* loud if znetboot is killed.

Just my 5 cents :)

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
