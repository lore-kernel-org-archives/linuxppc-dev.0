Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51256DDE05
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 18:34:47 +1000 (EST)
Subject: Re: Tickless Hz/hrtimers/etc. on PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <46968960.6090402@genesi-usa.com>
References: <46951C1A.4080001@genesi-usa.com> <8302.1184178785@neuling.org>
	<46955674.9090304@genesi-usa.com> <29941.1184255383@neuling.org>
	<46968960.6090402@genesi-usa.com>
Content-Type: text/plain
Date: Fri, 13 Jul 2007 18:34:34 +1000
Message-Id: <1184315674.6059.212.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-07-12 at 21:04 +0100, Matt Sealey wrote:
> We already have some ~20 for Efika support on top of 2.6.22 including
> minor bugfixes and stuff, and the Gentoo genpatches stuff. I really
> want
> to get a good start on CFS, hrtimers, dynticks and so on though and
> see
> if we can push it to users and get out some decent testing and bug
> reports. I think it will help everyone if it is not just a feature
> which
> hits mainline after 6 months through supposed maturity (when a lack of
> bug reports may well also be down to lack of interest).

Why haven't you submited those patches ? The merge window for 2.6.23 is
open _now_

Ben
