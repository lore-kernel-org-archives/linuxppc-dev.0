Date: Wed, 24 Sep 2003 14:19:46 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Andreas Oberritter <obi@saftware.de>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix build of ibmstb4 and ibmstbx25
Message-ID: <20030924141946.A9453@home.com>
References: <1064372689.822.13.camel@shiva.eth.saftware.de> <20030924171739.GA30820@ip68-0-152-218.tc.ph.cox.net> <1064437206.1807.42.camel@shiva.eth.saftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1064437206.1807.42.camel@shiva.eth.saftware.de>; from obi@saftware.de on Wed, Sep 24, 2003 at 11:00:07PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Sep 24, 2003 at 11:00:07PM +0200, Andreas Oberritter wrote:
>
> On Wed, 2003-09-24 at 19:17, Tom Rini wrote:
> > On Wed, Sep 24, 2003 at 05:04:49AM +0200, Andreas Oberritter wrote:
> >
> > > Hi Tom,
> > >
> > > config.in.diff adds two missing '$' for config variables in
> > > arch/ppc/config.in and the two other patches update the ocp definitions
> > > for the stb4xxx and stbx25xx CPUs, so they can be built again. I used
> > > linuxppc_2_4_devel, but they are needed for linuxppc-2.4, too.
> >
> > Applied.  Does this mean you have the HW and can test things?
>
> Thanks!
>
> Yes, I have a set-top-box using the stb4500. I don't have an stbx25xx
> yet, but there are or will be some interesting boxes on the market using
> it.
>
> I found two more bugs in linuxppc-2.4:
>
> ppc405_wdt.c is missing, but it is available as a config option.

This one is in my queue to cleanup up and verify on 44x.  It
probably got missed since there aren't many users.

> embed_config.c contains an #endif below #include <asm/io.h> without a
> matching #if.

This fix is in a set of mismerge fixes I'm going to push RSN.

> Unfortunately I can't send patches at the moment because my harddisk
> died partially this morning...
>
> Btw, thanks for applying the dbox2 patches! Will the watchdog code be
> merged in before 2.4.23, too?

I was going to clean it up first.

-Matt

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
