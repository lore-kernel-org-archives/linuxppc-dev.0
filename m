Return-Path: <egtvedt@samfundet.no>
Received: from cassarossa.samfundet.no (cassarossa.samfundet.no
 [IPv6:2001:700:300:1800::1919])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9870E2C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2012 16:41:52 +1000 (EST)
Date: Wed, 29 Aug 2012 07:56:25 +0200
From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] clk: Make the generic clock API available by default
Message-ID: <20120829055625.GA17753@samfundet.no>
References: <1346186104-4083-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346186104-4083-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Cc: linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <paulus@samba.org>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org,
 Haavard Skinnemoen <hskinnemoen@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Around Tue 28 Aug 2012 13:35:04 -0700 or thereabout, Mark Brown wrote:
> Rather than requiring platforms to select the generic clock API to make
> it available make the API available as a user selectable option unless the
> user either selects HAVE_CUSTOM_CLK (if they have their own implementation)
> or selects COMMON_CLK (if they depend on the generic implementation).
> 
> All current architectures that HAVE_CLK but don't use the common clock
> framework have selects of HAVE_CUSTOM_CLK added.
> 
> This allows drivers to use the generic API on platforms which have no need
> for the clock API at platform level.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> This depends on having one of the patches I've sent adding a generic
> clkdev.h added merged - Arnd was expecting to merge one of those, there
> was just the lack of clarity about the most practical Kbuild hookup.
> 
>  arch/arm/Kconfig            |   12 ++++++++++++
>  arch/avr32/Kconfig          |    1 +

For the AVR32 related changes

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

<snipp>

-- 
mvh
Hans-Christian Egtvedt
