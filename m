Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 3D863DDF64
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 07:16:28 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1639387anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jan 2008 12:16:27 -0800 (PST)
Message-ID: <fa686aa40801081216y7de4676fvbef94c6323235afe@mail.gmail.com>
Date: Tue, 8 Jan 2008 13:16:27 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Rigby" <jrigby@freescale.com>
Subject: Re: [PATCH 7/7] Add MPC512x PSC serial driver
In-Reply-To: <4783B74D.1040501@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-2-git-send-email-jrigby@freescale.com>
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
	<1199808093-15929-5-git-send-email-jrigby@freescale.com>
	<1199808093-15929-6-git-send-email-jrigby@freescale.com>
	<1199808093-15929-7-git-send-email-jrigby@freescale.com>
	<1199808093-15929-8-git-send-email-jrigby@freescale.com>
	<fa686aa40801080932g71fb6215wc3d6df107bec7238@mail.gmail.com>
	<4783B74D.1040501@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/8/08, John Rigby <jrigby@freescale.com> wrote:
> Thanks for the quick feedback Grant.
>
> Grant Likely wrote:
> > Exactly *how* different is the 5121 PSC from the 5200 PSC?  If it is
> > really different, then it makes sense to clone.
> The fifo handling has completely changed that is the main difference.
> >  In fact; I'd
> > duplicate the mpc52xx_psc.h file also to avoid any crossover.
> >
> I agree.
>
> > However, if the differences are manegable, I'd rather see a single
> > driver that can drive either type of PSC.  In fact, can you post a
> > diff between this driver and the original PSC driver?
> >
> I simple diff will mostly show the removal of arch/ppc support so
> won't be much help.  How about I do take a pass at a new version
> that supports 52xx and 512x but only for arch/powerpc?

I'm cool with that.  arch/powerpc support has *far* surpassed arch/ppc
for the 5200, so it may be time to just let the old stuff die, even if
it is a little ahead of schedule.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
