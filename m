Date: Wed, 24 Dec 2003 21:49:09 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Mark Powell <medp@primagraphics.co.uk>,
	linuxppc-embedded@lists.linuxppc.org,
	Davey <daveywu@transengines.com>, stefan.roese@esd-electronics.com
Subject: Re: patch for ibm 405ep emac driver in linux-2.4.22 and 2.4.23
Message-ID: <20031225054909.GA24915@gate.ebshome.net>
References: <C7FFFEA58B43D311920D0004ACE5333F10E4F46C@amer25.avnet.com> <29449.216.110.51.8.1071877375.squirrel@www.orkun.us> <1072105831.4163.15.camel@localhost.localdomain> <001d01c3c923$db2ca3c0$5100a8c0@davey> <3FE814FF.7020503@primagraphics.co.uk> <20031223101022.A23655@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031223101022.A23655@home.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Dec 23, 2003 at 10:10:22AM -0700, Matt Porter wrote:
>
> On Tue, Dec 23, 2003 at 10:12:15AM +0000, Mark Powell wrote:
> >
> > Davey wrote:
> >
> > >Some time ago Stefan and I had reported that both ethernet interfaces
> > >cannot work well together. Sorry I have lost all old mails when I
> > >reinstall my computer. We have find that this problem is caused by
> > >that the base address of eht1 is wrong set. Follow by my patch for
> > >linux-2.4.22 and linux-2.4.23. I have test the patch and it work well.
> >
> > shouldn't that just be:
>
> This is the right way to do it, we can't put that other hack in the
> kernel.  If somebody verifies this patch hen we can get it in.
>

Matt, I checked old-OCP version of ibm405ep.c and indeed it had
EMAC1_BASE there. Obviously this is a typo introduced during
conversion to new OCP.

I checked these definitions when Stefan first reported the problem
but failed to notice this :-(.

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
