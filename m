Return-Path: <flar@cynthia.pants.nu>
Received: from cynthia.pants.nu (adsl-216-102-214-42.dsl.snfc21.pacbell.net
	[216.102.214.42]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0E065DDECD
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 06:04:16 +1000 (EST)
Date: Sun, 3 Jun 2007 11:51:53 -0700
From: Brad Boyer <flar@allandria.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE: Remove remnants related to dead BLK_DEV_MAC_MEDIABAY
	CONFIG variable.
Message-ID: <20070603185153.GA25767@cynthia.pants.nu>
References: <Pine.LNX.4.64.0706031348550.24843@localhost.localdomain>
	<20070603172829.GA25404@cynthia.pants.nu>
	<200706032107.52152.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200706032107.52152.bzolnier@gmail.com>
Cc: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>,
	"Robert P. J. Day" <rpjday@mindspring.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jun 03, 2007 at 09:07:52PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Ehm, I'm guilty for this mistake since I've advised Robert
> to cc: wrong list (thinko caused by mediabay == ppc assumption).
> 
> Sorry for this. :)

Don't worry about it. I would have missed it if I wasn't active in
the m68k Mac support. I'm pretty sure the PowerBook 190 was the only
m68k Mac with a media bay, and it's really just a PB 5300 with the
ppc chip swapped out for a 68LC040 to make a cheaper model. They're
fundamentally the same system in most ways. Hopefully we can merge
more of the m68k Mac support code with the ppc Mac support at some
point in the future, but that's still a fair amount of work.

	Brad Boyer
	flar@allandria.com
