Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5C9EEDE11C
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 10:56:08 +1100 (EST)
Date: Thu, 15 Jan 2009 02:56:05 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Liu Dave <DaveLiu@freescale.com>
Subject: Re: [PATCH] mmc: Add driver for Freescale eSDHC controllers
Message-ID: <20090114235605.GA13531@oksana.dev.rtsoft.ru>
References: <20090114194631.GA25978@oksana.dev.rtsoft.ru>
	<D7CCA83BB0796C49BC0BB53B6AB1208907ABDB@zch01exm21.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <D7CCA83BB0796C49BC0BB53B6AB1208907ABDB@zch01exm21.fsl.freescale.net>
Cc: D'Abbraccio Joe-LJD015 <Joe.D'abbraccio@freescale.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Lai Kon-LKL001 <Konjin.Lai@freescale.com>,
	Xie Xiaobo-R63061 <X.Xie@freescale.com>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 15, 2009 at 07:37:00AM +0800, Liu Dave wrote:
> > This patch adds support for the Freescale Enhanced Secure Digital
> > Host Controller Interface as found in some Freescale PowerPC
> > microprocessors (e.g. MPC837x SOCs).
> 
> The Freescale ESDHC controller is basically compatible with the
> standard SDHC controller. but the eshdc expand some bits.
> 
> The esdhc.c is much like the orignal sdhci.c.
> it is possible to merge them.

Ah. I wonder why Freescale just didn't write some patches for sdhci,
but copied the code instead...

Thanks for the info, I'll look into merging the driver into sdhci.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
