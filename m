Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 75DAADDD09
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 08:14:28 +1000 (EST)
Message-ID: <46955674.9090304@genesi-usa.com>
Date: Wed, 11 Jul 2007 23:15:16 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: Tickless Hz/hrtimers/etc. on PowerPC
References: <46951C1A.4080001@genesi-usa.com> <8302.1184178785@neuling.org>
In-Reply-To: <8302.1184178785@neuling.org>
Content-Type: text/plain; charset=UTF-8
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Okay.

What I didn't want to do is spend a day sifting some other development
tree picking out what I think might be possibly sort of the right patches
for it.

I'd get it wrong because having not worked on it, I don't know what I am
even looking for.

And I don't want to run -rt or wireless-dev for the benefit of a single
feature. What I am after is something like Ingo Molnar throws out..
single patches done the old way, not git trees. It's so much easier to
handle and integrate for example into a Gentoo ebuild or to make a
tarball of accumulated patches from a certain release kernel.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Michael Neuling wrote:
>> Does anyone have the definitive patchset to enable the tickless hz,
>> some kind of hrtimer and the other related improvements in the PowerPC
>> tree?
> 
> Tony Breeds has been looking at this.  I think he wanted to clean his
> patch set up before he posted it.
> 
> Mikey
