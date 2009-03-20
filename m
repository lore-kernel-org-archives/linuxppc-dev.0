Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id EA645DDDB2
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 09:43:31 +1100 (EST)
Date: Sat, 21 Mar 2009 01:43:30 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: yamazaki <yamazaki-seiji@jcom.home.ne.jp>
Subject: Re: [PATCH 11/11] mmc: Add OpenFirmware bindings for SDHCI driver
Message-ID: <20090320224330.GA23390@oksana.dev.rtsoft.ru>
References: <20090316211405.GK9375@oksana.dev.rtsoft.ru>
	<200903192328.AA00740@cj3020122-b.jcom.home.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200903192328.AA00740@cj3020122-b.jcom.home.ne.jp>
Cc: sdhci-devel@list.drzeus.cx, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Ben Dooks <ben-linux@fluff.org>,
	Pierre Ossman <drzeus-sdhci@drzeus.cx>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

On Fri, Mar 20, 2009 at 08:28:39AM +0900, yamazaki wrote:
> Hi all,
> 
> I am running the Linux kernel 2.6.28.7 on my PPC8347 BRD.
> I have to write the driver of SDHCI driver(using R5C807 RICOH). 

RICOH? It should be a PCI SD/MMC controller, so you even don't
need any patches to make it work in 2.6.28.7. Just make sure your
.config file has following symbols enabled:

CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PCI=y
CONFIG_MMC_RICOH_MMC=y

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
