From: Brian Waite <waite@skycomputers.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: GT64260_eth (Ethernet) Driver
Date: Thu, 24 Jun 2004 07:23:17 -0400
Cc: "Mark A. Greer" <mgreer@mvista.com>,
	Dieu Morales <dieumorales@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
References: <20040620202719.25741.qmail@web60407.mail.yahoo.com> <40DA06BE.204@mvista.com> <1088066228.18627.3352.camel@hades.cambridge.redhat.com>
In-Reply-To: <1088066228.18627.3352.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200406240723.18346.waite@skycomputers.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



I think this is just a "sprout" Basically, Mark started an entire code
refactor for the 2.6 kernel. I started bugging him so he put up a terr where
we can colaborate on getting the code to a working state.
I don't think it is expected t live any longer than hey all the peices work
and boot a board. Today I don't think we have that. Ethernet driver and MPSC
driver are the 2 major sticking points right now.

Thanks
Brian

On Thursday 24 June 2004 04:37 am, David Woodhouse wrote:
> You are lost in a twisty maze of BK trees, all alike.
>
> On Wed, 2004-06-23 at 15:39 -0700, Mark A. Greer wrote:
> > You should sync up with Brian Waite (look at CC: list) who has been
> > looking at writing a new enet driver for the 2.6 kernel using the latest
> > bridge support code.  You can get a look at the latest support code by
> > cloning bk://source.mvista.com/linux-2.5-marvell.  Note the the mpsc
> > driver that's there still isn't working correctly.
>
> Ooh look another one. What's in here that merits it having its own tree
> and prevents it from being accepted upstream?
>
> Please be as specific as you can -- my task for the next few weeks
> involves making Dy-4 DMV-182 support happen.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
