Return-Path: <dvomlehn@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1.cisco.com [171.71.176.70])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-1.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6F75BB70AF
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Nov 2010 05:18:46 +1100 (EST)
Date: Wed, 24 Nov 2010 10:18:26 -0800
From: David VomLehn <dvomlehn@cisco.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
Message-ID: <20101124181825.GA17112@dvomlehn-lnx2.corp.sa.net>
References: <1290607413.12457.44.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290607413.12457.44.camel@concordia>
Cc: linux-mips <linux-mips@linux-mips.org>, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 25, 2010 at 01:03:33AM +1100, Michael Ellerman wrote:
> Hi all,
> 
> There were some murmurings on IRC last week about renaming the of_*()
> routines. I was procrastinating at the time and said I'd have a look at
> it, so here I am.
> 
> The thinking is that on many platforms that use the of_() routines
> OpenFirmware is not involved at all, this is true even on many powerpc
> platforms. Also for folks who don't know the OpenFirmware connection it
> reads as "of", as in "a can of worms".
> 
> Personally I'm a bit ambivalent about it, the OF name is a bit wrong so
> it would be nice to get rid of, but it's a lot of churn.
> 
> So I'm hoping people with either say "YES this is a great idea", or "NO
> this is stupid".
> 
> As step one I've just renamed as many routines as I could find to see
> what the resulting patch looks like, so we can quantify the churn. I
> also did device.of_node, which is used quite a bit.
> 
> Thoughts?

I'm looking at it the other way. There are inconsistencies in naming of
symbols and files we definitely should clean up. Since we're doing that,
let's take the opportunity to move from of* to dt*. With multiple
architectures adding device tree support, this is about the last chance
to do this without impacting too many people.
-- 
David VL
