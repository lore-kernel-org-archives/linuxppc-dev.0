Return-Path: <mpm@selenic.com>
Received: from waste.org (waste.org [66.93.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "waste.org", Issuer "waste.org" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0F7DDDDE19
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 12:18:06 +1100 (EST)
Subject: Re: 2.6.24-rc8-mm1: powerpc oopses
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080117170754.b5dd139b.akpm@linux-foundation.org>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
	<200801172315.28129.m.kozlowski@tuxland.pl>
	<20080117145105.ad968ea6.akpm@linux-foundation.org>
	<1200613194.3839.22.camel@cinder.waste.org>
	<20080117160513.3456b4eb.akpm@linux-foundation.org>
	<1200615168.3839.26.camel@cinder.waste.org>
	<20080117162913.0323c517.akpm@linux-foundation.org>
	<1200617237.3839.32.camel@cinder.waste.org>
	<20080117170754.b5dd139b.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 17 Jan 2008 19:16:50 -0600
Message-Id: <1200619010.13504.2.camel@cinder.waste.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, m.kozlowski@tuxland.pl, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-01-17 at 17:07 -0800, Andrew Morton wrote:
> That worked out nicely.

Cool, feel free to add:

Signed-off-by: Matt Mackall <mpm@selenic.com>

> Wasn't the old code potentially pte_unmap()ping the wrong address?  If we
> enter with addr==end?

Yes, that was busted.

-- 
Mathematics is the supreme nostalgia of our time.
