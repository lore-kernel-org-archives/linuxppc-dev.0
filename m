Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1DEAADE055
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 01:42:07 +1000 (EST)
Date: Fri, 23 May 2008 19:42:04 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: [PATCH 3/4] [MMC] mmc_spi: add polling support for the card
	detect line
Message-ID: <20080523154204.GA19803@polina.dev.rtsoft.ru>
References: <20080516165057.GC24196@polina.dev.rtsoft.ru>
	<20080517133633.5aa26938@mjolnir.drzeus.cx>
	<20080521184713.GA30284@polina.dev.rtsoft.ru>
	<20080521212831.523f344b@mjolnir.drzeus.cx>
	<20080522181713.GA26918@polina.dev.rtsoft.ru>
	<20080522213432.4a50629b@mjolnir.drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080522213432.4a50629b@mjolnir.drzeus.cx>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 22, 2008 at 09:34:32PM +0200, Pierre Ossman wrote:
[...]
> > Ok. How about this version?
> > 
> 
> Perfect. Unless there is some way you can pass flags in platform data?
> Using the lack of an init() to determine the need for polling is a bit
> circumstantial.

Aha, that's an idea, thanks. Implemented in the updated patches.

p.s.
I think, in case of capabilities, it's users' responsibility to not
issue bogus flags, so mmc_spi doesn't mask anything, it just passes
platform's caps. This also avoids drivers update when (if) new caps
will be implemented.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
