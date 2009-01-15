Return-Path: <drzeus-mmc@drzeus.cx>
Received: from smtp.drzeus.cx (82-117-125-11.tcdsl.calypso.net [82.117.125.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4C8DBDDEEF
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 17:40:01 +1100 (EST)
Date: Thu, 15 Jan 2009 07:39:55 +0100
From: Pierre Ossman <drzeus-mmc@drzeus.cx>
To: "Liu Dave" <DaveLiu@freescale.com>
Subject: Re: [PATCH] mmc: Add driver for Freescale eSDHC controllers
Message-ID: <20090115073955.11d20734@mjolnir.drzeus.cx>
In-Reply-To: <D7CCA83BB0796C49BC0BB53B6AB1208907ACF9@zch01exm21.fsl.freescale.net>
References: <20090114194631.GA25978@oksana.dev.rtsoft.ru>
	<D7CCA83BB0796C49BC0BB53B6AB1208907ABDB@zch01exm21.fsl.freescale.net>
	<20090114235605.GA13531@oksana.dev.rtsoft.ru>
	<20090115065502.1b719b06@mjolnir.drzeus.cx>
	<D7CCA83BB0796C49BC0BB53B6AB1208907ACF9@zch01exm21.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: D'Abbraccio Joe-LJD015 <Joe.D'abbraccio@freescale.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Xie
	Xiaobo-R63061 <X.Xie@freescale.com>,
	Lai Kon-LKL001 <Konjin.Lai@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 15 Jan 2009 14:11:09 +0800
"Liu Dave" <DaveLiu@freescale.com> wrote:

> > Probably because it was quicker. Samsung did the same thing, but now
> > Ben Dooks has patches to properly support it via sdhci.
> 
> Pierre,
> What samsung driver are you talking? Could you point it to me?
> 

I'm afraid I haven't seen any readily available sources for their
driver. If you meant Ben's version, you can find the latest revision
here:

http://marc.info/?t=122823266100005

Unfortunately marc.info didn't sort out the threading, but you should
be able to find all the patches there or some other LKML archive.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.
