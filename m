Return-Path: <yamazaki-seiji@jcom.home.ne.jp>
Received: from smtp11.m3.home.ne.jp (smtp11.m3.home.ne.jp [220.152.44.17])
	by ozlabs.org (Postfix) with ESMTP id 7D45DDDED7
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 11:13:45 +1100 (EST)
Message-Id: <200903210015.AA00742@cj3020122-b.jcom.home.ne.jp>
From: yamazaki <yamazaki-seiji@jcom.home.ne.jp>
Date: Sat, 21 Mar 2009 09:15:25 +0900
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 11/11] mmc: Add OpenFirmware bindings for SDHCI driver
In-Reply-To: <20090320224330.GA23390@oksana.dev.rtsoft.ru>
References: <20090320224330.GA23390@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sdhci-devel@list.drzeus.cx, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Ben Dooks <ben-linux@fluff.org>,
	Pierre Ossman <drzeus-sdhci@drzeus.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi 

Thank you for your reply.
I know RICOH has PCI SD/MMC controller. But R5C807 RICOH is not the PCI device
which is probably new product.

I made the "sdhci-of.c" from patch file,then I compiled it.
But is was not succeeded.
I thought the reason is the format of "the struct sdhci_of_data" is defferent from the 
kernel 2.6.28.7,
That is why I sent this question.

>Hi!
>
>On Fri, Mar 20, 2009 at 08:28:39AM +0900, yamazaki wrote:
>> Hi all,
>> 
>> I am running the Linux kernel 2.6.28.7 on my PPC8347 BRD.
>> I have to write the driver of SDHCI driver(using R5C807 RICOH). 
>
>RICOH? It should be a PCI SD/MMC controller, so you even don't
>need any patches to make it work in 2.6.28.7. Just make sure your
>.config file has following symbols enabled:
>
>CONFIG_MMC_SDHCI=y
>CONFIG_MMC_SDHCI_PCI=y
>CONFIG_MMC_RICOH_MMC=y
>
>-- 
>Anton Vorontsov
>email: cbouatmailru@gmail.com
>irc://irc.freenode.net/bd2
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-dev

----
yamazaki-seiji@jcom.home.ne.jp
