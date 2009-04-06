Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 4E6F4DDECA
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 00:33:56 +1000 (EST)
Message-ID: <49DA12C7.9000900@mlbassoc.com>
Date: Mon, 06 Apr 2009 08:33:43 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] spi_mpc83xx: Handles other Freescale processors
References: <20090404192802.GA12183@oksana.dev.rtsoft.ru>
	<6758B03E-2525-4754-83FA-643CED277CC6@kernel.crashing.org>
In-Reply-To: <6758B03E-2525-4754-83FA-643CED277CC6@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	David Brownell <dbrownell@users.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Apr 4, 2009, at 2:28 PM, Anton Vorontsov wrote:
> 
>> With this patch we'll able to select spi_mpc83xx driver on the MPC86xx
>> platforms. Let the driver depend on FSL_SOC, so we don't have to worry
>> about Kconfig anymore.
>>
>> Also remove the "experimental" dependency, the driver has been tested
>> to work on a various hardware, and surely not experimental anymore.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>> drivers/spi/Kconfig |   14 ++++++--------
>> 1 files changed, 6 insertions(+), 8 deletions(-)
> 
> this looks fine, but why don't we go ahead and rename things as well? 
> SPI_MPC83xx -> SPI_MPC8xxx, spi_mpc83xx.c -> spi_mpc8xxx.c

mpc8xxx implies mpc82xx (e.g. mpc8272) which is not the same controller
as on the mpc83xx

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
