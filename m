Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4B0B3DDE23
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 07:16:43 +1000 (EST)
Subject: Re: G5 doesn't shut down with current kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1222180713.18015.17.camel@johannes.berg>
References: <1222180713.18015.17.camel@johannes.berg>
Content-Type: text/plain
Date: Wed, 24 Sep 2008 07:16:37 +1000
Message-Id: <1222204597.8277.15.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-09-23 at 16:38 +0200, Johannes Berg wrote:
> Instead, I get an oops right after trying to disable the non-boot CPUs.
> 
> This was on 2.6.27-rc6-wl-01382-g0bea1f7-dirty.
> 
> http://johannes.sipsolutions.net/files/dsc_2274.jpg

Can you file that as a regression with Rafael ?

Thanks !
Ben.
