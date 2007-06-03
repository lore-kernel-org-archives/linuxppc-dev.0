Return-Path: <flar@cynthia.pants.nu>
Received: from cynthia.pants.nu (adsl-216-102-214-42.dsl.snfc21.pacbell.net
	[216.102.214.42]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 910F7DDEEC
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 05:14:44 +1000 (EST)
Date: Sun, 3 Jun 2007 10:28:29 -0700
From: Brad Boyer <flar@allandria.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: [PATCH] IDE: Remove remnants related to dead BLK_DEV_MAC_MEDIABAY
	CONFIG variable.
Message-ID: <20070603172829.GA25404@cynthia.pants.nu>
References: <Pine.LNX.4.64.0706031348550.24843@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0706031348550.24843@localhost.localdomain>
Cc: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>, bzolnier@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jun 03, 2007 at 01:52:02PM -0400, Robert P. J. Day wrote:
> Remove the two snippets of code conditional on the non-existent CONFIG
> variable CONFIG_BLK_DEV_MAC_MEDIABAY.

This is the wrong list. The macide driver is for m68k Macintoshes, so
you really need to send this to the linux-m68k list. It looks like this
was originally a copy of the IDE driver for ppc based Macintoshes and
this particular feature was never finished.

Just in case you don't know where to find the linux-m68k mailing list,
it is hosted on vger.kernel.org.

	Brad Boyer
	flar@allandria.com
