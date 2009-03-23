Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 15C67DDF1E
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 03:16:58 +1100 (EST)
Date: Mon, 23 Mar 2009 19:16:55 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: =?utf8?B?5bGx5bSO44CA57K+5LqM?= <yamazaki.seiji@kk.jp.panasonic.com>
Subject: Re: [PATCH 11/11] mmc: Add OpenFirmware bindings for SDHCI driver
Message-ID: <20090323161655.GA30262@oksana.dev.rtsoft.ru>
References: <200903210015.AA00742@cj3020122-b.jcom.home.ne.jp>
	<20090321004506.GA13031@oksana.dev.rtsoft.ru>
	<20090323152051.D2F9.YAMAZAKI.SEIJI@kk.jp.panasonic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090323152051.D2F9.YAMAZAKI.SEIJI@kk.jp.panasonic.com>
Cc: justinmattock@gmail.com, Ben Dooks <ben-linux@fluff.org>,
	Arnd Bergmann <arnd@arndb.de>, yamazaki <yamazaki-seiji@jcom.home.ne.jp>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sdhci-devel@list.drzeus.cx,
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

On Mon, Mar 23, 2009 at 03:34:45PM +0900, 山崎　精二 wrote:
> Hi 
> 
> I downloaded linux-2.6.29-rc8.tar.bz2,and I patched .
> I was succeeded. Thank you very match.
> But I have the other problem.
> 
> Compile was not succeeded.
> 
> Message is ...
> 
>  CALL    arch/powerpc/kernel/prom_init_check.sh
>   CC      drivers/mmc/host/sdhci-of.o
> drivers/mmc/host/sdhci-of.c:163: error: 'SDHCI_QUIRK_FORCE_BLK_SZ_2048' undeclared here (not in a function)
> drivers/mmc/host/sdhci-of.c:164: error: 'SDHCI_QUIRK_BROKEN_CARD_DETECTION' undeclared here (not in a function)
> drivers/mmc/host/sdhci-of.c:165: error: 'SDHCI_QUIRK_INVERTED_WRITE_PROTECT' undeclared here (not in a function)
> drivers/mmc/host/sdhci-of.c:167: error: 'SDHCI_QUIRK_NONSTANDARD_CLOCK' undeclared here (not in a function)
> drivers/mmc/host/sdhci-of.c:168: error: 'SDHCI_QUIRK_PIO_NEEDS_DELAY' undeclared here (not in a function)
> drivers/mmc/host/sdhci-of.c:169: error: 'SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET' undeclared here (not in a function)
[...]
> drivers/mmc/host/sdhci-of.c:181: warning: excess elements in struct initializer
> drivers/mmc/host/sdhci-of.c:181: warning: (near initialization for 'sdhci_esdhc.ops')
> make[3]: *** [drivers/mmc/host/sdhci-of.o] Error 1
> make[2]: *** [drivers/mmc/host] Error 2
> make[1]: *** [drivers/mmc] Error 2

All these errors indicate that you didn't apply all the patches.
You'll need all 11 patches from this series, not only the last
one.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
