Return-Path: <ben@fluff.org.uk>
Received: from kira.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5F615DE35C
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 01:36:01 +1100 (EST)
Date: Thu, 15 Jan 2009 14:35:35 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] mmc: Add driver for Freescale eSDHC controllers
Message-ID: <20090115143535.GT12431@fluff.org.uk>
References: <20090114194631.GA25978@oksana.dev.rtsoft.ru>
	<D7CCA83BB0796C49BC0BB53B6AB1208907ABDB@zch01exm21.fsl.freescale.net>
	<20090114235605.GA13531@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090114235605.GA13531@oksana.dev.rtsoft.ru>
Cc: Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	D'Abbraccio Joe-LJD015 <Joe.D'abbraccio@freescale.com>,
	linuxppc-dev@ozlabs.org, Lai Kon-LKL001 <Konjin.Lai@freescale.com>,
	Xie Xiaobo-R63061 <X.Xie@freescale.com>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 15, 2009 at 02:56:05AM +0300, Anton Vorontsov wrote:
> On Thu, Jan 15, 2009 at 07:37:00AM +0800, Liu Dave wrote:
> > > This patch adds support for the Freescale Enhanced Secure Digital
> > > Host Controller Interface as found in some Freescale PowerPC
> > > microprocessors (e.g. MPC837x SOCs).
> > 
> > The Freescale ESDHC controller is basically compatible with the
> > standard SDHC controller. but the eshdc expand some bits.
> > 
> > The esdhc.c is much like the orignal sdhci.c.
> > it is possible to merge them.
> 
> Ah. I wonder why Freescale just didn't write some patches for sdhci,
> but copied the code instead...

For the same reasons earthmen like tea.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
