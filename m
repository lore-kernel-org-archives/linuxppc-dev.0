Return-Path: <baruch@tkos.co.il>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 41A4CB7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 05:34:56 +1000 (EST)
Received: from tango.tkos.co.il (tango.tkos.co.il [62.219.50.35])
	by ozlabs.org (Postfix) with ESMTP id 5482ADDDE7
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 05:34:54 +1000 (EST)
Date: Thu, 9 Jul 2009 21:38:55 +0300
From: Baruch Siach <baruch@tkos.co.il>
To: Mark Bishop <mark@bish.net>
Subject: Re: [spi-devel-general] Questions in spi_mpc83xx.c
Message-ID: <20090709183855.GS16245@tarshish>
References: <20090709141648.ws3ak25ewwogwsc0@www.bish.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090709141648.ws3ak25ewwogwsc0@www.bish.net>
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mark,

On Thu, Jul 09, 2009 at 02:16:48PM -0400, Mark Bishop wrote:
> I haven't seen this before - the '##' in the function name.  This is ANCII C?

Of course. See pp. 90-91 in "The C Programming Language" second edition.

> 
> #define MPC83XX_SPI_TX_BUF(type)				\
> u32 mpc83xx_spi_tx_buf_##type(struct mpc83xx_spi *mpc83xx_spi)	\
> {								\
> 	u32 data;						\
> ....

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
