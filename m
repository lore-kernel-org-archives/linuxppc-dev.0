Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 15E2DDE63C
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 05:29:23 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67JTIat002710
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 15:29:18 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67JTBF9177344
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 13:29:11 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67JTBYs031912
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 13:29:11 -0600
Date: Mon, 7 Jul 2008 15:25:48 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Deputy maintainer for powerpc
Message-ID: <20080707152548.5075845f@zod.rchland.ibm.com>
In-Reply-To: <155B1079-39C4-4D15-B886-F904C424BC8C@kernel.crashing.org>
References: <18541.48403.490671.815858@cargo.ozlabs.ibm.com>
	<155B1079-39C4-4D15-B886-F904C424BC8C@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: lkml List <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Torvalds <torvalds@linux-foundation.org>, Linus
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 7 Jul 2008 09:44:31 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Jul 4, 2008, at 1:02 AM, Paul Mackerras wrote:
> 
> > I'm going to be on vacation for the next two weeks, and it looks
> > highly likely that Linus will open the 2.6.27 merge window during that
> > time, so I'm appointing Ben Herrenschmidt as my deputy maintainer.
> > During the next two weeks, he'll be the person collecting together any
> > further powerpc-related commits that need to go upstream, and sending
> > pull requests to Linus as necessary.
> >
> > This is the start of a longer-term transition which will ultimately
> > result in me handing over the powerpc architecture maintainership to
> > Ben.  Because of various work commitments, this will be a gradual
> > transition taking probably around 6 months.
> >
> > Paul.
> 
> Ben, Do you have a tree that you'll be using to collect things in?

I hope it's the same tree for this merge window.

In the future, I hope the semantics of the various branches of the
new tree either stays the same, or comes with a detailed description of
what branch means what (assuming there is a new tree at some point).

josh
