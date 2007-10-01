Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id E5686DDE16
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Oct 2007 05:27:30 +1000 (EST)
Date: Mon, 1 Oct 2007 12:19:37 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] Add platform support for the MPC837x RDB board
Message-ID: <20071001191937.GA5785@mag.az.mvista.com>
References: <11909173512321-git-send-email-ljd015@freescale.com>
	<20070927191036.GD7838@mag.az.mvista.com>
	<C908B0B881A6B949985D6BAA0D9469B402CD36A7@az33exm20.fsl.freescale.net>
	<20070927195351.GE7838@mag.az.mvista.com>
	<20070927150312.4eea96fd@weaponx.rchland.ibm.com>
	<20070927212830.GA9610@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070927212830.GA9610@lixom.net>
Cc: D'Abbraccio Joe-ljd015 <Joe.D'abbraccio@freescale.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 27, 2007 at 04:28:30PM -0500, Olof Johansson wrote:
> On Thu, Sep 27, 2007 at 03:03:12PM -0500, Josh Boyer wrote:
> > On Thu, 27 Sep 2007 12:53:51 -0700
> > "Mark A. Greer" <mgreer@mvista.com> wrote:
> > 
> > > On Thu, Sep 27, 2007 at 12:41:57PM -0700, D'Abbraccio Joe-ljd015 wrote:
> > > > Thanks for the advice, but I was just basing the list to post to on the
> > > > MAINTAINERS file which states that this is the one for Embedded PPC83XX.
> > > > If you still think that I should post to linuxppc-dev, let me know.
> > > 
> > > Yes, I think it would be better to repost to linuxppc-dev.
> > > 
> > > Does anyone have an objection to changing all of the:
> > > 
> > > 	"L:	linuxppc-embedded@ozlabs.org"
> > > 
> > > in MAINTAINERS to:
> > > 
> > > 	"L:	linuxppc-dev@ozlabs.org" ??
> > > 
> > > Kumar, Josh, Vitaly, et. al.?
> > 
> > I personally don't care either way.  I'm already subscribed to both
> > lists.
> > 
> > Makes sense to go to linuxppc-dev given the arch/powerpc migration.
> 
> I thought the -embedded list was created in the first place to keep some
> of the "noise" off of -dev (i.e. "I can't get interface <foo> to work on
> my custom <embedded eval board>-lookalike board, HELP!"). If people still
> care about keeping that on a separate list, then we shouldn't change it.

Yes, IIRC, that was the reason but now with the merge and low volume on this
list, it makes sense to me to just get rid of -embedded.

> I think the relevant people probably monitor this list (maybe not quite as
> frequently) to catch things. I even caught the first PWRficient-related
> question in a timely manner the other day. :-)

:)

> Still, that being said, patches will clearly get better exposure on -dev,
> especially device tree crap.

Definitely.  I'll propose this on -dev and see what people say.

Mark
