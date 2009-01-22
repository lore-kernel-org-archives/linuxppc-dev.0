Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E6D67DDED5
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 12:56:50 +1100 (EST)
Date: Thu, 22 Jan 2009 04:56:49 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-sdhci@drzeus.cx>
Subject: [PATCH RFC 0/10] Freescale "eSDHC" SDHCI support (was [PATCH] mmc:
	Add driver for Freescale eSDHC controllers)
Message-ID: <20090122015649.GA6835@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: sdhci-devel@list.drzeus.cx, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, Liu Dave <DaveLiu@freescale.com>,
	Joe D'Abbraccio <Joe.D'abbraccio@freescale.com>,
	linuxppc-dev@ozlabs.org, Konjin Lai <Konjin.Lai@freescale.com>,
	Ben Dooks <ben-linux@fluff.org>, Xie Xiaobo <X.Xie@freescale.com>
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

Seem to work indeed. Quite a lot of quirks needed though.

Patches on the way...

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
