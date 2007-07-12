Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 557BEDDE07
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 16:41:16 +1000 (EST)
Date: Thu, 12 Jul 2007 16:41:15 +1000
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Tickless Hz/hrtimers/etc. on PowerPC
Message-ID: <20070712064115.GO10345@bakeyournoodle.com>
References: <46951C1A.4080001@genesi-usa.com> <8302.1184178785@neuling.org>
	<46955674.9090304@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <46955674.9090304@genesi-usa.com>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 11, 2007 at 11:15:16PM +0100, Matt Sealey wrote:
 
> And I don't want to run -rt or wireless-dev for the benefit of a single
> feature. What I am after is something like Ingo Molnar throws out..
> single patches done the old way, not git trees. It's so much easier to
> handle and integrate for example into a Gentoo ebuild or to make a
> tarball of accumulated patches from a certain release kernel.

Hi Matt,
	In the near future I will have something that I can pass around
for review.  Which will be a quilt series of about 5 patches (based on
mainline).  I'll make sure to include you in the reviewers list.  At
this stage I'd hope they'll be in 2.6.24.

I have HRT in a state where you can enable it and it works, but NO_HZ
isn't quite right yet.

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
