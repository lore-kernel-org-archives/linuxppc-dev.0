Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 155C2DDE24
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 03:30:03 +1100 (EST)
Date: Tue, 15 Jan 2008 10:40:22 -0600
From: Olof Johansson <olof@lixom.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v4 0/3] OF-platform PATA driver
Message-ID: <20080115164022.GA24590@lixom.net>
References: <20080109190852.GA18827@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080109190852.GA18827@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
	Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I've applied 1/3 and 2/3 together with my electra_ide move to pasemi.git
for-2.6.25, and will ask Paul to pull that. Kumar said he'd take 3/3.

I also added the const to the match table as spotted by Stephen.


-Olof

On Wed, Jan 09, 2008 at 10:08:52PM +0300, Anton Vorontsov wrote:
> Hi all,
> 
> Here is the resend (aka v4) version of the OF-platform PATA
> driver and related patches.
> 
> Changes since v3:
> - Acked-by: Paul Mundt <lethal@linux-sh.org>
> - In the powerpc specific patch: update defconfig and use
>   machine_device_initcall -- this is new call found in the
>   galak/powerpc.git.
> 
> Changes since v2:
> - "PPC" added to PATA_PLATFORM "depends on" Kconfig entry;
>   I didn't remove EMBEDDED "depends on" -- this wasn't discussed
>   much and these patches should not depend on the decision.
> - cosmetic fixes;
> - "s/ioport_shift/reg_shift/g" patch dropped.
> 
> Changes since v1:
> - __pata_platform_probe now accepts pio_mask argument;
> - pata-platform compatible property renamed to ata-generic;
> - pata_of_platform understands pio-mode property. It's used to pass
>   pio_mask to the __pata_platform_probe. That is, in ata-generic
>   context pio-mode means "pio mode the bus already configured for";
> - New optional patch that renames pata_platform_info's
>   ioport_shift to reg_shift.
> 
> Changes since RFC:
> - nuked drivers/ata/pata_platform.h;
> - powerpc bits: proper localbus node added.
> 
> -- 
> Anton Vorontsov
> email: cbou@mail.ru
> backup email: ya-cbou@yandex.ru
> irc://irc.freenode.net/bd2
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
