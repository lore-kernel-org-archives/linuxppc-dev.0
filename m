From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 18 Apr 2003 19:57:40 -0700
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Fix prep boot in linuxppc_2_4_devel
Message-ID: <20030419025740.GA19495@rover.farnsworth.org>
References: <20030416173830.GM20197@host109.fsmlabs.com> <20030418210231.GB7065@ip68-0-152-218.tc.ph.cox.net> <20030419023238.GA8542@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030419023238.GA8542@ip68-0-152-218.tc.ph.cox.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Apr 19, 2003 at 02:32:38AM +0000, Tom Rini wrote:
>
> On Fri, Apr 18, 2003 at 02:02:31PM -0700, Tom Rini wrote:
>
> > On Wed, Apr 16, 2003 at 11:38:30AM -0600, Cort Dougan wrote:
> >
> > > This fixes the prep boot code so it will actually create a good SMP boot
> > > image.  The wrong variable was being used.
> >
> > Urk.  Can we kill znetboot / znetboot.initrd instead please?
>
> Or, for the potentially silent masses of you out there who do use this,
> please speak up.  I'm not really aware of anyone other than Cort who
> does use this target but am more than willing to stand corrected.

I find it convenient and use it quite often.

-Dale

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
