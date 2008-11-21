Return-Path: <david-b@pacbell.net>
Received: from smtp127.sbc.mail.sp1.yahoo.com (smtp127.sbc.mail.sp1.yahoo.com
	[69.147.65.186]) by ozlabs.org (Postfix) with SMTP id 157EADDF04
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 14:41:10 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Stefan Roese <sr@denx.de>
Subject: Re: [spi-devel-general] [PATCH v4] spi: Add PPC4xx SPI driver
Date: Thu, 20 Nov 2008 19:41:08 -0800
References: <1225451266-23740-1-git-send-email-sr@denx.de>
In-Reply-To: <1225451266-23740-1-git-send-email-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811201941.08468.david-b@pacbell.net>
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 31 October 2008, Stefan Roese wrote:
> +       dev_dbg(&spi->dev, "%s: mode %d, %u bpw, %d hz\n",
> +               __FUNCTION__, spi->mode, spi->bits_per_word,
> +               spi->max_speed_hz);

Oh, and checkpatch.pl would warn about __FUNCTION__ vs __func__ ...
