Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DCC72DDEF2
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 06:16:05 +1100 (EST)
Message-Id: <5FF82BD4-AA84-4645-A703-F146C226F07C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090122020041.GJ11492@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 10/10] mmc: Add OpenFirmware bindings for SDHCI driver
Date: Thu, 22 Jan 2009 13:15:01 -0600
References: <20090122015649.GA6835@oksana.dev.rtsoft.ru>
	<20090122020041.GJ11492@oksana.dev.rtsoft.ru>
Cc: sdhci-devel@list.drzeus.cx, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>,
	Joe D'Abbraccio <Joe.D'abbraccio@freescale.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Konjin Lai <Konjin.Lai@freescale.com>, Ben Dooks <ben-linux@fluff.org>,
	Pierre Ossman <drzeus-sdhci@drzeus.cx>, Xie Xiaobo <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 21, 2009, at 8:00 PM, Anton Vorontsov wrote:

> This patch adds a new driver: sdhci-of. The driver is similar to
> the sdhci-pci, it contains common probe code, and controller-specific
> ops and quirks.
>
> So far there are only Freescale eSDHC ops and quirks.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> drivers/mmc/host/Kconfig    |   10 ++
> drivers/mmc/host/Makefile   |    1 +
> drivers/mmc/host/sdhci-of.c |  274 ++++++++++++++++++++++++++++++++++ 
> +++++++++
> 3 files changed, 285 insertions(+), 0 deletions(-)
> create mode 100644 drivers/mmc/host/sdhci-of.c

Still griping about lack of OF binding docs for this.

:)

- k
