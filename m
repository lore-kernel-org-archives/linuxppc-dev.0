Date: Wed, 24 Sep 2003 14:53:24 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	Andreas Oberritter <obi@saftware.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix build of ibmstb4 and ibmstbx25
Message-ID: <20030924145324.C9453@home.com>
References: <1064372689.822.13.camel@shiva.eth.saftware.de> <20030924171739.GA30820@ip68-0-152-218.tc.ph.cox.net> <1064437206.1807.42.camel@shiva.eth.saftware.de> <20030924141946.A9453@home.com> <20030924213212.GD30820@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030924213212.GD30820@ip68-0-152-218.tc.ph.cox.net>; from trini@kernel.crashing.org on Wed, Sep 24, 2003 at 02:32:12PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Sep 24, 2003 at 02:32:12PM -0700, Tom Rini wrote:
> On Wed, Sep 24, 2003 at 02:19:46PM -0700, Matt Porter wrote:
> > On Wed, Sep 24, 2003 at 11:00:07PM +0200, Andreas Oberritter wrote:
> > > ppc405_wdt.c is missing, but it is available as a config option.

<snip>

> > I was going to clean it up first.
>
> I think he meant the dbox2 wdt changes.  Actually, I was hoping that you
> would post the driver + needed changes to arch/ppc to lkml and see if
> anyone comments on the code.
> those

Oh good, I saw the ppc405_wdt.c referenced above and figured he was
still talking about that. :)

-Matt

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
