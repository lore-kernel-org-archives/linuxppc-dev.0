Date: Tue, 8 Oct 2002 11:20:36 -0700
From: Matt Porter <porter@cox.net>
To: Andrew May <acmay@acmay.homeip.net>
Cc: Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
Message-ID: <20021008112036.A22215@home.com>
References: <3D995EC0.2000500@elsoft.ch> <20021002014219.GF1848@zax> <3D9AA452.5070004@elsoft.ch> <20021003011233.GC1102@zax> <20021006052314.GG27824@acmay.homeip.net> <20021006183120.A17129@home.com> <20021008041419.GF32555@zax> <20021008052136.GA26470@acmay.homeip.net> <20021008075609.A21266@home.com> <20021008173156.GA21980@acmay.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021008173156.GA21980@acmay.homeip.net>; from acmay@acmay.homeip.net on Tue, Oct 08, 2002 at 10:31:56AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Oct 08, 2002 at 10:31:56AM -0700, Andrew May wrote:
> > On Mon, Oct 07, 2002 at 10:21:36PM -0700, Andrew May wrote:
> >
> > I think we are all more or less in agreement.  Let me review a couple
> > scenarios so we all recall why we have a few different methodologies.
> > Here are the basic systems:
>
> ....
>
> > We can (and already do) support all three methodologies.  The
> > important thing is to keep supporting them and make it easy
> > to handle case #3 on 4xx stuff.
>
> Yes, I think we agree on this, but I am not sure it is that
> easy to currently handle case #1 on a 4xx system. Not too hard,
> but I did have to pull out some code to get things to work.

Absolutely.  It'll get fixed as one of the pieces of this 4xx
reorg that Paul mentioned.  Specifically, this will be possible
once the flow-through is no longer through the common file.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
