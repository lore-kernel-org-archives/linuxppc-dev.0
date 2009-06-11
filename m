Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 88BAAB714B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 11:35:43 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6FF5DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 11:35:42 +1000 (EST)
Subject: Re: [PATCH 00/33] My PS3-specific patches for 2.6.31
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1244683951.4674.5.camel@concordia>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244670213.3352.11.camel@pasglop>  <4A302B67.4000401@mlbassoc.com>
	<1244681320.5739.5.camel@pasglop> <1244683951.4674.5.camel@concordia>
Content-Type: text/plain
Date: Thu, 11 Jun 2009 11:35:28 +1000
Message-Id: <1244684128.5739.30.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Gary Thomas <gary@mlbassoc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-06-11 at 11:32 +1000, Michael Ellerman wrote:
> The way I think of it is that the "merge window" is the time for
> maintainers to merge with Linus.
> 
> So if you're sending patches to a maintainer you need to have sent all
> your patches to them _before_ then. So the merge window for you is the
> weeks prior to the "merge window".

Right. But a patch generally needs time to be reviewed, spun several
times, etc... so just the week before the merge window is probably too
late :-)

A good rule is that people should start sending things to the list for
review about one kernel release in advance :-)

Now, -rc4 should generally be the wakeup call. It's when I start
frowning even on bug fixes, and putting together a next branch, at least
normally. I can be flexible but people need to try to play nicely too.

Cheers,
Ben.
