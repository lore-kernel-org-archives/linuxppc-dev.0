Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6F218DDE19
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 20:48:38 +1000 (EST)
Date: Tue, 10 Jul 2007 14:53:36 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: olof@lixom.net (Olof Johansson)
Subject: Re: [PATCH 1/2] [ide] mmio ide support
Message-ID: <20070710145336.6f8b5770@localhost.localdomain>
In-Reply-To: <20070707150147.GA2202@lixom.net>
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
	<20070707150147.GA2202@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 7 Jul 2007 10:01:47 -0500
Olof Johansson wrote:

> On Sat, Jul 07, 2007 at 01:48:52PM +0400, Vitaly Bordug wrote:
> > 
> > This adds support for MMIO IDE device like CompactFlash 
> > in TrueIDE mode.
> 
> Doesn't this duplicate most of pata_platform, but as the
> no-longer-preferred legacy IDE device? Did you try using
> pata_platform instead?
> 
prolly true,
but as Sergei told upper, that's not an option so far due to internal reasons. But it is likely to be followed-up
that way a little bit later.

> 
> -Olof


-- 
Sincerely, Vitaly

-- 
Sincerely, Vitaly
