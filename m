Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C4256DDEE2
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 08:51:08 +1000 (EST)
Subject: Re: Deputy maintainer for powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <155B1079-39C4-4D15-B886-F904C424BC8C@kernel.crashing.org>
References: <18541.48403.490671.815858@cargo.ozlabs.ibm.com>
	<155B1079-39C4-4D15-B886-F904C424BC8C@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 08 Jul 2008 08:50:31 +1000
Message-Id: <1215471031.8970.153.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>, lkml List <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-07 at 09:44 -0500, Kumar Gala wrote:
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

I've setup a tree on kernel.org yes, but there's nothing useful in
it yet (it has 3 branches, master, merge and next, but they are
currently pointing to the exact same spot as Paul's).

I've started collecting things yesterday and sending comments, I'll
push some new stuff out today or tomorrow. Mostly been "training" with
git and patchwork so far :-)

Ben.
