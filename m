Return-Path: <SRS0+4b2dc8d9df8b47542035+453+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org
	[81.187.226.107])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7C5CE2BDB5
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Nov 2004 21:00:50 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1100847411.25521.42.camel@gaston>
References: <1100847411.25521.42.camel@gaston>
Content-Type: text/plain
Message-Id: <1100854258.21273.273.camel@baythorne.infradead.org>
Mime-Version: 1.0
Date: Fri, 19 Nov 2004 08:50:58 +0000
Cc: linuxppc-dev@ozlabs.org
Subject: Re: TEST: Sleep suppport for iBook G4 & Aluminium PowerBooks (ATI
	based)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2004-11-19 at 17:56 +1100, Benjamin Herrenschmidt wrote:
> (Message cross-posted to several lists, please do _NOT_ reply to all of
> them).

I forwarded it to fedora-ppc@lists.infradead.org too.

Since I started using the previous patch and actually suspending, I've
been seeing the GNOME panel and window list die frequently, and
occasionally other X apps. When X apps have died which were started from
the command line it seemed to be a spurious SIGPIPE, strangely.

I don't _think_ I've ever seen it immediately after booting; only after
suspend/resume. But that could be just a coincidence. Likewise the way
it started when I added the sleep patch _could_ just be a coincidence --
I was still running Fedora rawhide and updating other packages (and
there were other kernel changes) at that time, so a lot of other things
changed too... but has anyone else seen similar behaviour?

-- 
dwmw2
