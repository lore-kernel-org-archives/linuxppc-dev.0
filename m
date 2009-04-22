Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	by ozlabs.org (Postfix) with ESMTP id 5B694DE03F
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 18:29:46 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v6] spi: Add PPC4xx SPI driver
Date: Wed, 22 Apr 2009 10:29:38 +0200
References: <1231411250-25380-1-git-send-email-sr@denx.de>
	<200904212236.12904.david-b@pacbell.net>
In-Reply-To: <200904212236.12904.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200904221029.38454.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 22 April 2009, David Brownell wrote:
> On Thursday 08 January 2009, Stefan Roese wrote:
> > This adds a SPI driver for the SPI controller found in the IBM/AMCC
> > 4xx PowerPC's.
>
> Note that given some patches now in the mm tree, this needs
> something like the appended fixup.  Some common code has now
> moved into the spi core.

So would you accept the driver for 2.6.31 merge with your suggested change 
below? If yes, I'll generate a 7th version.

Thanks.

Best regards,
Stefan
