Return-Path: <jangiels@speakeasy.net>
Received: from mail6.speakeasy.net (mail6.speakeasy.net [216.254.0.206])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C12F2BC0F
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Oct 2004 23:41:46 +1000 (EST)
From: Jeff Angielski <jangiels@speakeasy.net>
To: Richard Williams <richard_williams@stratexnet.com>
In-Reply-To: <A3240F62EF3C2749B1A25D3BC9548F4148BCF1@ExchWENZ02.wenz.global.vpn>
References: <A3240F62EF3C2749B1A25D3BC9548F4148BCF1@ExchWENZ02.wenz.global.vpn>
Content-Type: text/plain
Message-Id: <1098366099.2302.6.camel@nighteyes.localdomain>
Mime-Version: 1.0
Date: Thu, 21 Oct 2004 09:41:39 -0400
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: RE: SCC UART stalling/hanging - progress
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2004-10-21 at 01:06, Richard Williams wrote:
> I think you might have the same problem that I came across some time 
> ago. I posted this but got no reply and never had time to fully 
> investigate and test my solution since the problem (noise on receive) 
> was fixed in hardware.
> 
> http://article.gmane.org/gmane.linux.ports.ppc.embedded/3884/match=8xx+uart+driver+problems

Thanks for the suggestion.  Unfortunately, even with your changes I
still see the SCC stalling during my high speed loopback tests.

Jeff Angielski
