Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BA206DDE06
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 16:28:20 +1100 (EST)
Subject: Re: [PATCH 00/16] xics and ipi cleanups for 2.6.28
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <patch-xics-0@bga.com>
References: <patch-xics-0@bga.com>
Content-Type: text/plain
Date: Mon, 13 Oct 2008 16:28:00 +1100
Message-Id: <1223875680.8157.232.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-10-10 at 06:56 -0500, Milton Miller wrote:
> The first two patches in this series implememnt a couple of bug
> fixes for the xics interrupt controller accessed as found in pseries
> hardware.  The next several patches implement some code orginization
> and cleanups, followed by some changes to reduce code or flag the
> behavior to generic code.
> 
> The last 5 patces are independent of the xics changes, although the
> first one affects xics.  They are designed to reduce interrupt
> overhead for interprocessor interupts.  

I've merged 1..13. The other ones, I'm less sure about, we need to
have a closer look (in addition to Geert comments) and they are
probably not .28 material anyway.

Cheers,
Ben.
