Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B5A9EDDED9
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 05:05:22 +1100 (EST)
Date: Fri, 6 Feb 2009 21:05:20 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-sdhci@drzeus.cx>
Subject: [PATCH RFC 0/11] FSL eSDHC support: second call for comments
Message-ID: <20090206180520.GA16123@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Ben Dooks <ben-linux@fluff.org>, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sdhci-devel@list.drzeus.cx
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

There were only a few comments on the previous version. So, here is
the second call for comments.

Changes since the first RFC:

- Use of_iomap() in sdhci-of.c (suggested by Arnd Bergmann). Also added
  Arnd's Acked-by: line for the sdhci-of patch.
- Kconfig help text improved (thanks to Matt Sealey and M. Warner Losh).
- In "sdhci: Add quirk to suppress PIO interrupts during DMA transfers"
  patch: sdhci_init() now clears SDHCI_PIO_DISABLED flag, otherwise we
  won't disable PIO interrupts after suspend.
- New patch: "sdhci: Add type checking for IO memory accessors"

That's all, for now.


Pierre, what do you think about memory accessors, what is your
preference regarding mem ops? Some options were discussed here:
http://lkml.org/lkml/2009/1/22/261


Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
