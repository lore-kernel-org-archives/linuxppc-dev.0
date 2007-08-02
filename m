Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3645EDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 07:39:55 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l72KXbbO030508
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 16:33:37 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l72Ldq5J207954
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 15:39:52 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l72LdqMd012057
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 15:39:52 -0600
Date: Thu, 2 Aug 2007 16:39:51 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [patch 00/14] Current 4xx patch series
Message-ID: <20070802163951.11c398ee@weaponx.rchland.ibm.com>
In-Reply-To: <f8tgfm$e2g$1@sea.gmane.org>
References: <41060.0659474314$1184697204@news.gmane.org>
	<f8tgfm$e2g$1@sea.gmane.org>
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

On Thu, 2 Aug 2007 20:57:26 +0000 (UTC)
Hollis Blanchard <hollisb@us.ibm.com> wrote:

> On Tue, 17 Jul 2007 13:15:47 -0500, Josh Boyer wrote:
> 
> > For those interested, here's my current 4xx patch series.  There are a few
> > cleanups as a pre-requisite for 40x support, some minimal Walnut support, and
> > another round of Bamboo patches.  These are all based off of Paul's current
> > tree.
> 
> Bamboo is booting for me with your patches. Let's get them in soon...

I plan on submitting a series to Paul tomorrow-ish for 2.6.24.  Too
late for 2.6.23.

> > Ethernet for 4xx in general is still provided by the out-of-tree emac rewrite
> > that Ben and David have poked at.  If it doesn't get merged soon, I'll take
> > a look at getting it working again.
> 
> Please!

Someone brought up the fact that the EMAC rewrite is mostly just
changing probing code and the guts are still similar to the current
EMAC driver.  I haven't really looked into it yet, but if that's true,
I'd be curious as to why it was done that way.

Either way, I'm hoping we can get something into 2.6.24.

josh
