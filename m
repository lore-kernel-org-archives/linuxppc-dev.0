Return-Path: <david-b@pacbell.net>
Received: from smtp127.sbc.mail.sp1.yahoo.com (smtp127.sbc.mail.sp1.yahoo.com
	[69.147.65.186]) by ozlabs.org (Postfix) with SMTP id 78BA1B7E41
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2010 08:03:04 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 2/4] of/gpio: Add support for two-stage registration for
	the of_gpio_chips
Date: Tue, 26 Jan 2010 13:02:43 -0800
References: <20100125180957.GA5380@oksana.dev.rtsoft.ru>
	<201001252236.16141.david-b@pacbell.net>
	<20100126174347.GB20319@oksana.dev.rtsoft.ru>
In-Reply-To: <20100126174347.GB20319@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201001261302.44424.david-b@pacbell.net>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Bill Gatliff <bgat@billgatliff.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 26 January 2010, Anton Vorontsov wrote:
> 
> > Why have two options, instead of just the first/simpler one??
> 
> Because I2C/SPI drivers allocate (and register) gpio_chip structures
> by themselves, so the first option is a no-go.

You should be mentioning such issues in the patch comments.
