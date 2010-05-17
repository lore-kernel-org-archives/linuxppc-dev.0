Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by ozlabs.org (Postfix) with ESMTP id 8A5B7B7DA9
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 01:40:13 +1000 (EST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glppd-linuxppc64-dev@m.gmane.org>)
	id 1OE2Bj-0006Oi-Or
	for linuxppc-dev@ozlabs.org; Mon, 17 May 2010 17:25:03 +0200
Received: from adsl-ull-134-189.46-151.net24.it ([151.46.189.134])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Mon, 17 May 2010 17:25:03 +0200
Received: from ppc.addon by adsl-ull-134-189.46-151.net24.it with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Mon, 17 May 2010 17:25:03 +0200
To: linuxppc-dev@ozlabs.org
From: nello martuscielli <ppc.addon@gmail.com>
Subject: Re: "event-scan failed" logflood
Date: Mon, 17 May 2010 12:58:25 +0000 (UTC)
Message-ID: <loom.20100517T145602-17@post.gmane.org>
References: <20100513111603.3352.qmail@kosh.dhis.org>
	<1273786104.21352.190.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh <at> kernel.crashing.org> writes:

_omissis__
> 
> Ok, that gives us a good thing to use to not do the scanning then. If
> that's 0 then we assume it's a bogus OF and we disable the scan
> completely. I'll do a patch later today, though feel free to beat me to
> it.
> 
> Cheers,
> Ben.
> 

hi, is there available that patch?
With the fresh new 2.6.34 the logflood problem is still present.

thanks,
--nello
