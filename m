Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Mon, 14 Jul 2003 07:31:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Pantelis Antoniou <panto@intracom.gr>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ethernet PHY chip discovery not working on 855T with 971/972 chips
Message-ID: <20030714143110.GA1211@ip68-0-152-218.tc.ph.cox.net>
References: <3F124BF5.6070803@intracom.gr> <20030714075810.D95FAC6D82@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030714075810.D95FAC6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jul 14, 2003 at 09:58:05AM +0200, Wolfgang Denk wrote:

> Dear Pantelis,
>
> in message <3F124BF5.6070803@intracom.gr> you wrote:
> >
> > >>IIRC the last time we such discussions simply nothing  happened:  see
> > >>for example to code for dp_alloc / dp_free that was submitted several
> > >>times.
> > >
> > >google knows nothing of this, can you give a pointer into the thread
> > >please?  Thanks.
> > >
> > >
> > I was the one that sent the patches (search for dpalloc).
>
> I was referring to a much older implementation  of  this  feature.  I
> sent it to Tom nearly two years ago:
>
> 	Subject: Re: Modifications to linuxppc_2_4_devel
> 	From: Wolfgang Denk <wd@denx.de>
> 	Date: Wed, 29 Aug 2001 23:57:30 +0200
> 	To: Tom Rini <trini@kernel.crashing.org>
>
> The patch in question was named "PATCH-006-dpfree+uart".

I really wish I had looked into making mutt keep a copy of sent mail a
lot sooner.  I don't suppose you have a copy of my reply to that as
well?  I suspect it was either "Can you break the uart stuff out from
the dpfree stuff" and you didn't, or "This is large and intrusive and
I'd feel better if I could make Dan Malek look at it".

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
