Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 643AC679F6
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 08:04:28 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC] alsa integer control ranges
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jaroslav Kysela <perex@suse.cz>
In-Reply-To: <Pine.LNX.4.61.0605161430220.9330@tm8103.perex-int.cz>
References: <1147780945.29795.110.camel@johannes>
	<Pine.LNX.4.61.0605161430220.9330@tm8103.perex-int.cz>
Content-Type: text/plain
Date: Wed, 17 May 2006 08:04:18 +1000
Message-Id: <1147817058.6753.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	ALSA development <alsa-devel@alsa-project.org>,
	Benjamin Berg <benjamin@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-05-16 at 14:31 +0200, Jaroslav Kysela wrote:
> On Tue, 16 May 2006, Johannes Berg wrote:
> 
> > Apparently all alsa userspace programs including alsamixer suck. Hence,
> > this patch is required to make them work properly. Why is it so hard to
> > do these additions/subtractions in the program or maybe even in the alsa
> > library? The alsa libraries already think they know better and mess up
> > all kinds of things.
> 
> It's better to fix apps, if they are broken.

Problem is, they are currently all broken (pretty much) and thus unless
we want to release a driver that won't work with any current distros,
we'll have to whack the ranges :(

Ben.
