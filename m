Return-Path: <david-b@pacbell.net>
Received: from n20.bullet.mail.mud.yahoo.com (n20.bullet.mail.mud.yahoo.com
	[68.142.206.147]) by ozlabs.org (Postfix) with SMTP id 328C4DDEDA
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 19:02:40 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v6] spi: Add PPC4xx SPI driver
Date: Wed, 22 Apr 2009 01:56:02 -0700
References: <1231411250-25380-1-git-send-email-sr@denx.de>
	<200904212236.12904.david-b@pacbell.net>
	<200904221029.38454.sr@denx.de>
In-Reply-To: <200904221029.38454.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200904220156.02440.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 22 April 2009, Stefan Roese wrote:
> On Wednesday 22 April 2009, David Brownell wrote:
> > On Thursday 08 January 2009, Stefan Roese wrote:
> > > This adds a SPI driver for the SPI controller found in the IBM/AMCC
> > > 4xx PowerPC's.
> >
> > Note that given some patches now in the mm tree, this needs
> > something like the appended fixup.  Some common code has now
> > moved into the spi core.
> 
> So would you accept the driver for 2.6.31 merge with your suggested change 
> below? If yes, I'll generate a 7th version.

Hold on until I send the rest of my review comments; almost done.
Sorry for the delay.  Yes, I think a 2.6.31 merge should be doable.

- Dave


> 
> Thanks.
> 
> Best regards,
> Stefan
> 
> 
