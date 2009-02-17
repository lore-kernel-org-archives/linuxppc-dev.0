Return-Path: <ben@fluff.org.uk>
Received: from kira.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 548B0DDDB6
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 03:32:32 +1100 (EST)
Date: Tue, 17 Feb 2009 16:31:21 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH RFC 0/13] FSL eSDHC support
Message-ID: <20090217163121.GA15020@fluff.org.uk>
References: <20090213144630.GA13436@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090213144630.GA13436@oksana.dev.rtsoft.ru>
Cc: Ben Dooks <ben-linux@fluff.org>, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sdhci-devel@list.drzeus.cx,
	Pierre Ossman <drzeus-sdhci@drzeus.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 13, 2009 at 05:46:30PM +0300, Anton Vorontsov wrote:
> Hi all,
> 
> Thanks for the comments on the previous version, here comes another
> RFC...
> 
> Changes since the second RFC:
> - Addressed all comments that were raised by Pierre Ossman.
>   There were too many to mention them all, so here is the link:
>   http://lkml.org/lkml/2009/2/6/320
> 
> Changes since the first RFC:
> - Use of_iomap() in sdhci-of.c (suggested by Arnd Bergmann). Also added
>   Arnd's Acked-by: line for the sdhci-of patch.
> - Kconfig help text improved (thanks to Matt Sealey and M. Warner Losh).
> - In "sdhci: Add quirk to suppress PIO interrupts during DMA transfers"
>   patch: sdhci_init() now clears SDHCI_PIO_DISABLED flag, otherwise we
>   won't disable PIO interrupts after suspend.
> - New patch: "sdhci: Add type checking for IO memory accessors"

It would be useful to know what Pierre thinks of these, I would like
to update the sdhci-s3c binding before the next merge window.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
