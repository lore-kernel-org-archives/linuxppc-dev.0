Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3D853DDECF
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 00:19:00 +1000 (EST)
Date: Wed, 23 May 2007 09:14:07 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Kconfig warnings on latest GIT
In-Reply-To: <1179928646.14317.6.camel@johannes.berg>
Message-ID: <Pine.LNX.4.64.0705230913420.535@localhost.localdomain>
References: <200705080004.14570.ismail@pardus.org.tr>
	<20070508143127.38fafa3c.kim.phillips@freescale.com>
	<4640D988.1040504@freescale.com>
	<20070510051042.GA16812@verge.net.au>
	<1178811570.3806.18.camel@johannes.berg>
	<20070511012216.GB10715@verge.net.au>
	<1178883937.8896.11.camel@johannes.berg>
	<20070514013230.GJ3588@verge.net.au>
	<1179147311.2647.47.camel@johannes.berg>
	<Pine.LNX.4.64.0705140923470.24559@gate.crashing.org>
	<1179159951.2647.49.camel@johannes.berg>
	<943F0161-121D-4697-AE69-78BD605A8033@kernel.crashing.org>
	<1179928646.14317.6.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
	ppc-dev dev ML <linuxppc-dev@ozlabs.org>,
	Simon Horman <horms@verge.net.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 23 May 2007, Johannes Berg wrote:

> On Wed, 2007-05-23 at 07:37 -0500, Kumar Gala wrote:
>
> > Was my patch ok, if so I'll push it up through my git tree to paul?
>
> Yeah, looks fine to me, or will the ARCH=ppc folks then scream and want
> that added to the Kconfig there as well?

I can't imagine they will since pmac is only supported in ARCH=powerpc.

- k
