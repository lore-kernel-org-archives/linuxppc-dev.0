Return-Path: <david-b@pacbell.net>
Received: from smtp123.sbc.mail.sp1.yahoo.com (smtp123.sbc.mail.sp1.yahoo.com
	[69.147.64.96]) by ozlabs.org (Postfix) with SMTP id 38390DE04A
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 13:37:20 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 3/4] spi: Add OF binding support for SPI busses
Date: Thu, 22 May 2008 19:05:32 -0700
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516193613.28030.13950.stgit@trillian.secretlab.ca>
	<20080521151928.GA28857@polina.dev.rtsoft.ru>
In-Reply-To: <20080521151928.GA28857@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200805221905.32288.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, fabrizio.garetto@gmail.com,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 21 May 2008, Anton Vorontsov wrote:
> > +++ b/drivers/spi/spi_of.c
> 
> I think better placement for this is drivers/of, no?

Yes please.
