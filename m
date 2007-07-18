Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AF02CDDF01
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 20:18:45 +1000 (EST)
Date: Wed, 18 Jul 2007 12:53:02 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 51/61] cpm_uart: Be an of_platform device when using
	arch/powerpc.
Message-ID: <20070718125302.415a9b4d@localhost.localdomain>
In-Reply-To: <20070718013606.GW15238@ld0162-tx32.am.freescale.net>
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
	<20070718013606.GW15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 17 Jul 2007 20:36:06 -0500
Scott Wood wrote:

> The existing OF glue code was crufty and broken.  Rather than fix it,
> it has been removed, and the serial driver now talks to the device
> tree directly.
> 
> The non-CONFIG_PPC_MERGE code can do away once CPM platforms are
> dropped from arch/ppc (which will hopefully be soon).

Was is verified to boot on arch/ppc setup? 

-- 
Sincerely, Vitaly
