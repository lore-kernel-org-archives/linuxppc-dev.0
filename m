Return-Path: <dedekind@infradead.org>
Subject: Re: [PATCH 1/3 v3] mtd: physmap_of: Add multiple regions and
	concatenation support
From: Artem Bityutskiy <dedekind@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <alpine.LFD.2.00.0904161936090.12608@baythorne.infradead.org>
References: <1239883845-17804-1-git-send-email-sr@denx.de>
	<fa686aa40904160626k118cea3cvc0db38a2277e45b8@mail.gmail.com>
	<200904161537.59048.sr@denx.de>
	<fa686aa40904160646v75a98e02s446fd89c08cfebae@mail.gmail.com>
	<1239889899.3390.216.camel@localhost.localdomain>
	<alpine.LFD.2.00.0904161936090.12608@baythorne.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Apr 2009 11:26:18 +0300
Message-Id: <1239956778.3390.262.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	linux-mtd@lists.infradead.org, devicetree-discuss@ozlabs.org
Reply-To: dedekind@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-16 at 19:38 +0100, David Woodhouse wrote:
> On Thu, 16 Apr 2009, Artem Bityutskiy wrote:
> 
> > On Thu, 2009-04-16 at 07:46 -0600, Grant Likely wrote:
> >> On Thu, Apr 16, 2009 at 7:37 AM, Stefan Roese <sr@denx.de> wrote:
> >>> On Thursday 16 April 2009, Grant Likely wrote:
> >>>>> Signed-off-by: Stefan Roese <sr@denx.de>
> >>>>> Reviewd-by: Grant Likely <grant.likely@secretlab.ca>
> >>>>
> >>>> Yup, still looks good to me.  What boards has this been tested on?
> >>>
> >>> I tested this version on PPC405EX Kilauea equipped only one "standard"
> >>> Spansion S29GL512 NOR chip. And a slightly modified version on an MPC8360
> >>> board (kmeter1) which is equipped with the Intel P30 part mentioned in the
> >>> bindings description. Slightly modified since this board support is not yet
> >>> pushed upstream and currently using v2.6.28 (physmap_of.c has received minor
> >>> modifications after 2.6.28 release).
> >>
> >> Okay.  It will be good to get this one into -next for some testing
> >> exposure.  Unless he asks me to do otherwise, I'll leave this one to
> >> David to pick up.
> >
> > David usually picks up stuff just before or during merge window,
> > so if you want linux-next exposure, you need to have some extra
> > care.
> 
> I don't necessarily do that on purpose; it just works out that way when 
> I'm busy.

Yeah, not that I try to blame you, but I think we need to expose stuff
to linux-next. And people who send patches are frustrated when their
stuff gets no attention for very long time.

I understand that MTD tree maintenance is a burden, and you are very
busy, and no one pays you for this job. Thanks for doing it!

I'm going to try to help you. I've just created a git tree where
I'll push patches I consider OK and I approve. Here it is:
git://git.infradead.org/users/dedekind/l2-mtd-2.6.git

My hope is that you would look at that tree from time to time
and pull it. At least you may be sure I looked at the patches and
did some validation. This should save your time and help MTD
users.

Thanks.

-- 
Best regards,
Artem Bityutskiy (Битюцкий Артём)
