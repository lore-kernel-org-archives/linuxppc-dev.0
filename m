Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EAF4ADE18E
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 06:32:46 +1100 (EST)
Message-ID: <45BE4BD8.4050701@am.sony.com>
Date: Mon, 29 Jan 2007 11:32:40 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/16] ps3: system bus minor mmio fix
References: <45BAC20A.8040107@am.sony.com>
	<1169928417.24996.205.camel@localhost.localdomain>
	<20070128084239.GA6311@lst.de>
In-Reply-To: <20070128084239.GA6311@lst.de>
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Hellwig wrote:
> On Sun, Jan 28, 2007 at 07:06:57AM +1100, Benjamin Herrenschmidt wrote:
>> Note that I personally think that drivers/ps3 is a very wrong place for
>> the ps3 system bus. It should stay in arch/powerpc/platform/ps3
> 
> Yes, absolutely.  We should not spreads things all over the tree do
> make understanding the code even more difficult than all the lv1
> braindamage already makes it.

I'm really disappointed that you both feel that way.  Why didn't you say so several
months ago when I first posted that?  I also don't think it is a good place, since
I need to expose a bunch of platform specifics in asm-powerpc/ps3.h, which would
better stay in my platform/ps3/platform.h.  When I had that stuff in the platform
directory there was criticism that it shouldn't go there, so I moved it out.  I'll
make a patch for RFC and see what happens.

-Geoff
