Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 696A8B7167
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 10:48:48 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B781ADDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 10:48:47 +1000 (EST)
Subject: Re: [PATCH 00/33] My PS3-specific patches for 2.6.31
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gary Thomas <gary@mlbassoc.com>
In-Reply-To: <4A302B67.4000401@mlbassoc.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244670213.3352.11.camel@pasglop>  <4A302B67.4000401@mlbassoc.com>
Content-Type: text/plain
Date: Thu, 11 Jun 2009 10:48:40 +1000
Message-Id: <1244681320.5739.5.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-06-10 at 15:53 -0600, Gary Thomas wrote:

> Trying to understand the process (in preparation for any patches
> I may want to push upstream) - how can this be too late for 2.6.31?
> 2.6.30 just came out today...

I'm taking the liberty to reply to the list here because I think
more people need to understand that problem :-)

Because the process is such that new features can only be merged
during the 2 weeks merge window, which started ... yesterday.

Also, it's frowned upon to have lots of new stuff close to the end of
the merge window.

The idea is that stuff to go into 2.6.31 should have essentially been
ready to merge -before- the merge window opens, ie, before 2.6.30 is
released, for us maintainers to be ready to push things out when the
merge window open and spend that time sorting out collisions &
conflicts, -not- reviewing new features that have been sent way too
late.

In addition, before being merged, patches should generally be post long
in advance since they are likely to go through several revisions as
people review and comment on them. This process must happen long before
the patch is queued up for the actual merge.

So when the merge window opens, it's too late to have your patch be
submitted for the first time. Patches that have been submitted a while
ago and just didn't make it yet into my "next" branch due to my own
lazyness are generally fine. Bug fixes too, at least until -rc3 or -rc4,
after which only major bug fixes and regressions are accepted.

Cheers,
Ben.
